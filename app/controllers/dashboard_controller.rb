class DashboardController < ApplicationController

  skip_before_action :admin?


  def index
    person = Person.find(current_user.person_id)

    @my_milestones = person.milestones.where('status = ?',Milestone.statuses[:pending]).order('LOWER(title)')
    @my_mentees = person.mentees.order('LOWER(name)')

    respond_to do |f|
      f.json { render json: name_and_path()}
      f.html { render }
    end

  end


  def name_and_path ()

    {"name" => "Dashboard", "url" => dashboard_path}

  end

  def report


    if current_user_admin?
      @milestones = Milestone.all.order('LOWER(title)')
    else
      @milestones = get_mentees_milestones(current_person)
    end

    if request.get?
      @show_review_table = current_user_admin? || current_person.has_mentees?
      @review_table_header = current_user_admin? ?
        t('dashboard.review.admin.header') : t('dashboard.review.mentees.header')

      @people = Person.all.order(:name)
      @categories = Category.all.order(:name)

    else #es un post enviado por datatables

      # filtrar

      @milestone = @milestone.where("due_date >= ?", params[:due_date_from].to_datetime.strftime('%F')) if params[:due_date_from].present?
      @milestone = @milestone.where("due_date <= ?", params[:due_date_to].to_datetime.strftime('%F')) if params[:due_date_to].present?

      people_ids = params[:columns]['people'][:search][:value]
      cat_id = params[:columns]['category'][:search][:value]

      @milestone = @milestone.where(:category_id, cat_id) if cat_id

      if people_ids.present? then
        people_ids_cant = people_ids.split(',').length
        @milestone = @milestone.joins("INNER JOIN (SELECT person_milestones.milestone_id FROM person_milestones WHERE person_milestones.person_id IN (#{people_ids}) GROUP BY person_milestones.milestone_id HAVING count(milestone_id)=#{people_ids_cant}) as pm ON milestones.id = pm.milestone_id ")
      end

      if tags_ids.present? then
        tags_ids_cant = tags_ids.split(',').length
        @milestone = @milestone.joins("INNER JOIN (SELECT milestones_tags.milestone_id FROM milestones_tags WHERE milestones_tags.tag_id IN (#{tags_ids}) GROUP BY milestones_tags.milestone_id HAVING count(milestone_id)=#{tags_ids_cant}) as tm ON milestones.id = tm.milestone_id ")
      end


      if request.format.json?
        # ordenar
        if params[:order].present?
          col = params[:columns][params[:order]['0'][:column]][:name]
          dir = params[:order]['0'][:dir]
          @milestone =@milestone.order ("#{col} #{dir}")
        end

        @recordsTotal = Milestone.all.size #Total records, before filtering (i.e. the total number of records in the database)
        @recordsFiltered = @milestone.size #Total records, after filtering (i.e. the total number of records after filtering has been applied - not just the number of records being returned for this page of data).
        @milestone= @milestone.limit(params['length']).offset(params['start'])
      end

    end

    respond_to do |f|
      f.html { render :report}
    end

  end

  private

  def get_mentees_milestones(person)
    milestones = []
    person.mentees.each do |mentee|
      milestones = milestones | mentee.pending_milestones
    end

    milestones
  end

end
