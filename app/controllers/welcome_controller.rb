class WelcomeController < ApplicationController

  skip_before_action :loged?
  skip_before_action :admin?

  def index
    if ! current_user
      @navigation_bar_visible = false
    else
      person = Person.find_by(email: current_user.person_id)
      if person.mentees.empty? && !person.admin?
        redirect_to root_path
      else
        redirect_to '/dashboard/'
      end
    end
  end
end