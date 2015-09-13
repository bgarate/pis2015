class WelcomeController < ApplicationController
  skip_before_action :admin?, only:[:index]
  def index

    #@msj = String.new('Bienvenido a Alfred!')
  end
end