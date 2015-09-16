class MilestonesController < ApplicationController

  skip_before_action :loged?, only:[:callback,:unregistered]
  skip_before_action :admin?

  def index
    @milestone= Milestone.all
  end

  def new
    @milestone=Milestone.new
  end

  def create
    @milestone=Milestone.new(milestone_params)
    @milestone.save
    redirect_to @milestone
  end

  def create_from_person
    @person=Person.find(params[:person_id])
    @milestone= @person.milestones.create(milestone_params)
    redirect_to @milestone
  end

  def show
    @milestone=Milestone.find(params[:id])
  end

  def destroy
    @milestone= Milestone.find(params[:id])
    @milestone.destroy
    redirect_to milestones_path
  end

  private
  def milestone_params
    params.require(:milestone).permit(:title,:due_date,:description,:status, :icon, :created_at, :updated_at)
  end

  def add_milestones_dates
    #TODO: Debo checkear si soy mentor?
    #TODO: Como consigo el milestone para setearle la fecha de fin?
    milestone = Milestone.find_by(id: params[:milestone_id])
    milestone.update(due_date: params[:due_date]) if milestone
  end
end