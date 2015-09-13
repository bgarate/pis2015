class PeopleController < ApplicationController

  skip_before_action :admin?, only:[:show]

  def index
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
  end

  def create
    @person = Person.new(person_params)
    @person.save
    if @person.valid?
      redirect_to @person
    else
      redirect_to '/people/new'
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :email, :cellphone, :phone, :birth_date, :start_date)
  end


end
