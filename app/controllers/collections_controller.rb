class CollectionsController < ApplicationController

  before_action :get_collection, only: [:show, :destroy, :generate]

  def get_collection
    @collection = Collection.find_by(id: params[:id])
  end


  def new
    @templates = Template.all
  end

  def create
    @collection = Collection.new(collection_params)

    #@collection.save

    #unless params[:collection_templates].nil?
    #  params[:collection_templates].each do |t|
    #    template = Template.find(t[:template])
    #    days = t[:days]
    #    elem = CollectionTemplate.new(collection: @collection, template: template, days: days)
    #    @collection.collection_templates << elem
    #  end
    #end

    #Agregar Plantillas selecionadas
    (1..Integer(params[:count])).each do |i|
      if params["temp#{i}"] && params["offset#{i}"]
        template = Template.find_by(id: params["temp#{i}"])
        days = params["offset#{i}"]
        elem = CollectionTemplate.new(collection: @collection, template: template, days: days)
        @collection.collection_templates << elem
      end
    end

    @collection.save

    if @collection.valid?
      flash.notice = "'#{collection_params[:title]}' " + t('messages.create.success')
    else
      flash.alert = "'#{collection_params[:title]}' " + t('messages.create.error')
    end

    redirect_to '/collections/'
  end

  def index
    @collections = Collection.all
    respond_to do |f|
      f.json { render json: name_and_path(@collections)}
      f.html { render }
    end
  end


  def show
    #@templates = @collection.collection_templates
    redirect_to('/collections/')
  end


  def destroy
    unless @collection.nil?
      title = @collection.title
      @collection.destroy
      flash.notice = "#{title} " + t('messages.delete.success')
    end
    redirect_to '/collections/'
  end


  def generate
    p = Person.find_by(id: params[:person_id])
    unless @collection.nil? || p.nil?
      templates = @collection.collection_templates
      templates.each do |ct|
        t = Template.find(ct.template_id)
        days = ct.days
        if t && p
          m = Milestone.new
          m.title= t.title
          m.description= t.description
          m.category = t.category
          m.icon= t.icon
          m.tags = t.tags
          m.people<<(p)

          #AUTHOR
          m.author_id = current_user.person_id

          #DUE_DATE
          if days > 0
            m.due_date = Date.today + days
          elsif days == 0
            m.due_date = Date.today
          end

          #Crear documento adjunto
          if t.resource
            u = current_user
            session = GoogleDrive.login_with_oauth(u.oauth_token)
            begin
              #traigo el archivo
              f = session.file_by_url(t.resource.url)
              #lo copio
              fuploaded = f.copy("#{m.title}")
              #agregar permisos a la gente asociada al hito
              m.people.each do |p|
                fuploaded.acl.push(
                    {:type => 'user', :value => p.email, :role => 'writer'})
              end

              #se logro encontrar el resource
              r = Resource.new
              r.doc_id= fuploaded.resource_id
              r.title= fuploaded.title
              r.url= fuploaded.human_url
              m.resources<<(r)

            rescue Google::APIClient::ClientError
              #no se logro encontrar el resorce
              driveerr = t(:driveerrormsj)
            rescue GoogleDrive::Error
              #url no es valida
              driveerr = t(:invalidurl)
            rescue URI::InvalidURIError
              #url no es valida
              driveerr = t(:invalidurl)
            end
          end

          #Crear eventos en google calendar
          client = Google::APIClient.new
          client.authorization.access_token = current_user.oauth_token
          service = client.discovered_api('calendar', 'v3')
          if m.due_date && (!m.start_date || m.start_date != m.due_date)

            @event = {
                'summary' => "#{m.title} - Fin (Alfred)",
                'description' => m.description,
                'start' => { 'date' => m.due_date },
                'end' => { 'date' => m.due_date },
                'attendees' => [] }
            for i in 0..(m.people.count-1)
              @event['attendees'][i]={ "email" => m.people[i].email }
            end

            @set_event = client.execute(:api_method => service.events.insert,
                                        :parameters => {'calendarId' => current_person.email, 'sendNotifications' => true},
                                        :body => JSON.dump(@event),
                                        :headers => {'Content-Type' => 'application/json'})
          end

          m.save!

          if m.valid?
            if driveerr.nil?
              flash.notice = t('collections.generate.success')
            else
              flash.notice = t('collections.generate.success') + " \n(#{t(:driveerrormsj)}: #{driveerr})"
            end
          else
            flash.alert = t('collections.generate.error')
          end
        end
      end
    end
    redirect_to :back
  end


  def collection_params
    params.require(:collection).permit(:title,:description, :icon)
  end

end