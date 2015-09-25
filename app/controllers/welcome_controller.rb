class WelcomeController < ApplicationController

  skip_before_action :loged?
  skip_before_action :admin?

  def index
    @navigation_bar_visible = false
  end
end