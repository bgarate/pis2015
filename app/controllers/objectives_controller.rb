class ObjectivesController < ApplicationController

  before_action :get_milestone, only: [:create,:check, :destroy]
  skip_before_action :admin?, only: [:create, :check, :destroy]


  def get_milestone
    @milestone=Milestone.find(params[:milestone_id])
  end

  def create
    @objective= @milestone.objectives.create(objective_params)
    @milestone.updated_at = Time.now
    @milestone.save!

    redirect_to @milestone

  end

  def check
    @objective=@milestone.objectives.find(params[:objective_id])
    @objective.checked=true
    @objective.save!
    @milestone.updated_at = Time.now
    @milestone.save!
    redirect_to @milestone
  end

  def destroy
    @objective= @milestone.objectives.find(params[:id])
    @objective.destroy
    redirect_to @milestone
  end



  private
  def objective_params
    params.require(:objective).permit(:description, :created_at, :updated_at, :milestone_id)
  end


end