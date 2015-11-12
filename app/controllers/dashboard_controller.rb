class DashboardController < ApplicationController

  skip_before_action :admin?


  def index
    person = Person.find(current_user.person_id)

    @my_milestones = person.milestones.where('status = ?',Milestone.statuses[:pending]).order('LOWER(title)')
    @my_mentees = person.mentees.order('LOWER(name)')



    if current_user_admin?
      @milestones = Milestone.all.where('status = ?',Milestone.statuses[:pending]).order('LOWER(title)')
    else
      if (get_mentees_milestones(current_person)).length > 0
        @milestones = get_mentees_milestones(current_person).where('status = ?',Milestone.statuses[:pending]).order('LOWER(title)')
      else
        @milestones = get_mentees_milestones(current_person)
      end
    end

    if request.get?
      @show_review_table = current_user_admin? || current_person.has_mentees?
      @review_table_header = current_user_admin? ?
        t('dashboard.review.admin.header') : t('dashboard.review.mentees.header')

      @people = Person.all.order(:name)
      @categories = Category.all.order(:name)

    else #es un post enviado por datatables

      # filtrar

      @milestones = @milestones.where("due_date >= ?", params[:due_date_from].to_datetime.strftime('%F')) if params[:due_date_from].present?
      @milestones = @milestones.where("due_date <= ?", params[:due_date_to].to_datetime.strftime('%F')) if params[:due_date_to].present?

      people_ids = params[:people].split(",")

      cat_id = params[:category]

      @milestones = @milestones.where("category_id = ?", cat_id) if cat_id.present?

      if people_ids.length > 0 then
        @milestones = @milestones.joins("INNER JOIN (
                                        SELECT person_milestones.milestone_id
                                        FROM person_milestones
                                        WHERE person_milestones.person_id IN (#{people_ids.to_s.gsub(%{"},%{'}).gsub("[","").gsub("]","")})
                                        GROUP BY person_milestones.milestone_id
                                        HAVING count(milestone_id)=#{people_ids.length}) as pm
                                      ON milestones.id = pm.milestone_id ")
      end

      if request.format.json?
        @recordsTotal = Milestone.all.size #Total records, before filtering (i.e. the total number of records in the database)
        @recordsFiltered = @milestones.size #Total records, after filtering (i.e. the total number of records after filtering has been applied - not just the number of records being returned for this page of data).
        @milestones = @milestones.limit(params['length']).offset(params['start'])
      end

    end

    respond_to do |f|
      f.json {render partial: 'review_table_content'}
      f.html {render :index}
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
