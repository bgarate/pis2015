class WelcomeController < ApplicationController

  skip_before_action :loged?
  skip_before_action :admin?

  def index
    #PARA TESTEAR A MANO
  end
end