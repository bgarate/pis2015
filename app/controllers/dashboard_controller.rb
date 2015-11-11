class DashboardController < ApplicationController

  skip_before_action :admin?


  def index
    person = Person.find(current_user.person_id)
    @my_mentees = person.mentees.order('LOWER(name)')

    @show_review_table = current_user_admin? || current_person.has_mentees?
    @review_table_header = current_user_admin? ?
      t('dashboard.review.admin.header') : t('dashboard.review.mentees.header')

    @my_milestones = person.milestones.where('status = ?',Milestone.statuses[:pending]).order('LOWER(title)')


    if(current_user_admin?)
      @milestones = Milestone.all.order('LOWER(title)')
    else
      @milestones = get_mentees_milestones(current_person)
    end

    @people = Person.all.order(:name)
    @categories = Category.all.order(:name)


    respond_to do |f|
      f.json { render json: name_and_path()}
      f.html { render }
    end

  end


  def name_and_path ()

    {"name" => "Dashboard", "url" => dashboard_path}

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
