class MilestonesController < ApplicationController


  before_action :get_milestone, only: [:add_category, :next_status, :next_status_rej]
  before_action :get_milestone_by_id, only: [:feedback?, :update, :edit, :show, :destroy]
  before_action :get_category, only: [:add_category]
  before_action :is_authorized?, only: [:edit,:update,:next_status, :next_status_rej, :destroy,:add_category]
  skip_before_action :admin?

  def is_authorized?
    unless can_modify_milestone? @milestone.id
      flash.alert = t('not_authorized')
      redirect_to '/people'
    end
  end

  def get_milestone
    @milestone=Milestone.find(params[:milestone_id])
  end

  def get_milestone_by_id
    @milestone=Milestone.find_by(id: params[:id])
    if @milestone.nil?
      redirect_to '/milestones'
    end
  end

  def get_category
    @category=Category.find(params[:category_id])
  end

  def index
    @milestone= Milestone.all.order('LOWER(title)')
    @tags = Tag.all.order(:name)
    @people = Person.all.order(:name)
    @categories = Category.all.order(:name)

    respond_to do |f|
      f.json { render json: name_and_path(@milestone)}
      f.html { render }
    end

  end

  def new
    u = User.find_by(id: session[:user_id])
    p = Person.find_by(id: u.person_id)
    @identifier =  u.person_id
    @person = Person.find_by(id: @identifier)

    #redirect_to '/people'
    @cats=Category.all.order('LOWER(name)').collect {|t| [t.name, t.id, 'isfeedback' => t.is_feedback]}
    @authors=Person.all.where('id NOT in (?)', @identifier).order('LOWER(name)').collect {|t| [t.name, t.id]}
    @tags=Tag.all.order('LOWER(name)')

    if current_user_admin?
      #@people= Person.all.where('id NOT in (?)', @identifier)
      @people= Person.all
    else
      @people= p.mentees.where('mentee_id NOT in (?) ', @identifier)
      @people<<p
    end
    @people = @people.sort_by{|p| p.name }
    @redirect_url = request.headers["Referer"]
  end


  def create
    @person = nil
    if params[:person_id]
      @person=Person.find(params[:person_id])
      @milestone= @person.milestones.create(milestone_params)
    else
      @milestone = Milestone.create(milestone_params)
    end

    @milestone.tag_ids = params[:tags]
    #CATEGORIES
    category=Category.find(params[:milestone][:category_id])
    @milestone.category=category

    #AUTHOR
    @milestone.author_id = current_user.person_id

    #ASSIGNED
    if params[:people]!=nil
      params[:people].each do |p|
      @person2=Person.find(p)
      @milestone.people<<@person2
      end
    end

    if category.is_feedback? && params[:milestone][:feedback_author_id]!=''
      @milestone.feedback_author_id=params[:milestone][:feedback_author_id]
      unless @milestone.people.exists?(@milestone.feedback_author_id)
        @milestone.people<<@milestone.feedback_author
      end
    end

    #Crear eventos en google calendar
    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    service = client.discovered_api('calendar', 'v3')
    if @milestone.start_date

      @event = {
          'summary' => "#{@milestone.title} (Alfred)",
          'description' => @milestone.description,
          'start' => { 'date' => @milestone.start_date },
          'end' => { 'date' => @milestone.start_date },
          'attendees' => [] }
      for i in 0..(@milestone.people.count-1)
        @event['attendees'][i]={ "email" => @milestone.people[i].email }
      end

      @set_event = client.execute(:api_method => service.events.insert,
                                  :parameters => {'calendarId' => current_person.email, 'sendNotifications' => true},
                                  :body => JSON.dump(@event),
                                  :headers => {'Content-Type' => 'application/json'})
    end
    if @milestone.due_date && (!@milestone.start_date || @milestone.start_date != @milestone.due_date)

      @event = {
          'summary' => "#{@milestone.title} - Fin (Alfred)",
          'description' => @milestone.description,
          'start' => { 'date' => @milestone.due_date },
          'end' => { 'date' => @milestone.due_date },
          'attendees' => [] }
      for i in 0..(@milestone.people.count-1)
        @event['attendees'][i]={ "email" => @milestone.people[i].email }
      end

      @set_event = client.execute(:api_method => service.events.insert,
                                  :parameters => {'calendarId' => current_person.email, 'sendNotifications' => true},
                                  :body => JSON.dump(@event),
                                  :headers => {'Content-Type' => 'application/json'})
    end
    
    @milestone.save



    if @milestone.valid?
      flash.notice = "'#{milestone_params[:title]}' " + t('messages.create.success')
    else
      flash.alert = "'#{milestone_params[:title]}' " + t('messages.create.error')
    end

    if @person
      redirect_to @person
    else
      if params[:redirect_url]
        redirect_to params[:redirect_url]
      else
        redirect_to root_path
      end
    end
  end


  def add_category
    @category.milestones<<@milestone
    redirect_to @milestone
  end
  # Por ahora queda asi, deberia ser @milestone.category= @category

  def show
    if @milestone
      @notes = @milestone.get_visible_notes(current_person)
    else
      redirect_to root_path
    end
  end

  def destroy
    @milestone.notes.each do |n|
      n.destroy
    end
    @milestone.destroy
    #redirect_to milestones_path
    redirect_to milestones_path
  end

  def edit
    @cats=Category.all.order('LOWER(name)').collect {|t| [t.name, t.id, 'isfeedback' => t.is_feedback]}
    @authors=Person.all.order('LOWER(name)').collect {|t| [t.name, t.id]}
    @tags = Tag.all.order('LOWER(name)')
    user= Person.find(current_user.person_id)
    if current_user_admin?
      @people= Person.all.where('id NOT in (?)', @milestone.people.map{|p| p.id})
    else
      @people= user.mentees.where('mentee_id NOT in (?)', @milestone.people.map{|p| p.id})
      unless @milestone.people.exists?(user.id)
        @people<<user
      end
    end
    @people = @people.sort_by{|p| p.name }
    @category_name = @milestone.category.name
  end

  def update
    category=Category.find(params[:milestone][:category_id])
    @milestone.category = category

    if params[:people]!=nil
      params[:people].each do |p|
        @person2=Person.find(p)
        @milestone.people<<@person2
        # @milestone.updated_at= Time.now #esto lo asigna activerecord automaticamente.
        @milestone.save
      end
    end
    if category.is_feedback? && params[:milestone][:feedback_author_id]!=''
      @milestone.feedback_author_id=params[:milestone][:feedback_author_id]
      unless @milestone.people.exists?(@milestone.feedback_author_id)
        @milestone.people<<@milestone.feedback_author
      end
    else
      @milestone.feedback_author_id=nil
    end

    if @milestone.update_attributes(milestone_params)
      @milestone.tag_ids = params[:tags]

      if request.referer.include? "/people/" # TODO: Solucion desprolija
        redirect_to :back
      else
        redirect_to @milestone
      end

    else
      render :edit
    end
  end

  helper_method :feedback?
  def feedback?
    return @milestone.category.is_feedback?
  end

  def next_status
    if @milestone.status == 'pending'
      @milestone.status= 'done'
      @milestone.completed_date = Date.today
    else
      @milestone.status= 'pending'
    end

    @milestone.save!
    redirect_to :back
  end

  def next_status_rej
    if @milestone.status == 'rejected'
      @milestone.status= 'pending'
    else
      @milestone.status= 'rejected'
      @milestone.deleted_date = Date.today
    end
    @milestone.save!
    redirect_to :back
  end

  ## SE PASO AL MODELO Milestone
  # def filter_note_by_visibility(note)
  #     (note.visibility=='every_body') ||
  #     (note.author_id==current_person.id) || #la hice yo?
  #     (note.visibility=='mentors' && Person.find(note.author_id).mentors.exists?(current_person.id)) || #si es para mentores, soy su mentor
  #     (current_person.admin?)
  # end

  private

  def milestone_params
    params.require(:milestone).permit(:title, :start_date, :due_date,:description,:status, :icon, :category_id)
  end


  def name_and_path (milestone)
    milestone.map do |p|
      {"name" => p.title, "url" => milestone_path(p)}
    end
  end


end
