class WelcomeController < ApplicationController
  def index
    #PARA TESTEAR A MANO
    #per = Person.new
    #per.name = 'Alfred'
    #per.email = 'alfred.pis.2015@gmail.com'
    #per.save!
    @msj = String.new('Bienvenido a Alfred!')
  end
end