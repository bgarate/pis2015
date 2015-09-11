class PeopleController < ApplicationController

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
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :email,:celphone, :phone, :birth_date, :init_date, :finish_date)
  end
end
