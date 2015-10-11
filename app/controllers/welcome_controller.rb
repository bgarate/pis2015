class WelcomeController < ApplicationController

  skip_before_action :loged?
  skip_before_action :admin?

  def index
    if ! current_user
      @navigation_bar_visible = false
    else
      redirect_to root_path
    end
  end
end