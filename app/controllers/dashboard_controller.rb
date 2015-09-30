class DashboardController < ApplicationController


  def index
    u = User.find_by(id: session[:user_id])
    redirect_to action: 'show', id: u.person_id
  end

  def show

    person = Person.find_by(id: params[:id])

    @my_mentees = person.mentees

    @my_milestones = person.milestones.where('due_date > ?',Date.today)
  end

end
