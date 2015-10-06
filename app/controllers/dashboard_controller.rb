class DashboardController < ApplicationController

  before_action :is_authorized?
  skip_before_action :admin?


  def is_authorized?
    @person=Person.find(current_user.person_id)
    if @person.mentees.any?
    else
      flash.alert = t('not_authorized')
      redirect_to '/people/index'
    end
  end


  def index
    #u = User.find_by(id: session[:user_id])

    person = Person.find(current_user.person_id)
    #person = Person.find_by(id: params[:u.person_id])

    @my_mentees = person.mentees

    #@mentees  = []

    #@my_mentees.each do |m|
      #p = Person.new
      #p.id << m.id
      #p.name <<  m.name
      #p.milestones << m.milestones.where("status != ?",:pending).order("due_date ASC, created_at DESC").limit(2)

      #@mentees << p
    #end

    @my_milestones = person.milestones.where('due_date > ?',Date.today)


    respond_to do |f|
      f.json { render json: name_and_path()}
      f.html { render }
    end

  end

  def show


  end

  def name_and_path ()

    {"name" => "Dashboard", "url" => dashboard_path}

  end

end
