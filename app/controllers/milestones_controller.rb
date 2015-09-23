class MilestonesController < ApplicationController

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

  def add_category
    @milestone=Milestone.find(params[:milestone_id])
    @category=Category.find(params[:category_id])
    @category.milestones<<@milestone
    redirect_to @milestone
  end
  # Por ahora queda asi, deberia ser @milestone.category= @category

  def show
    @milestone=Milestone.find(params[:id])
  end

  def destroy
    @milestone= Milestone.find(params[:id])
    @milestone.notes.each do |n|
      n.destroy
    end
    @milestone.destroy
    redirect_to milestones_path
  end
	
  def edit
    @milestone = Milestone.find(params[:id])
  end
	
  def update
    @milestone = Milestone.find(params[:id])
    if @milestone.update_attributes(milestone_params)
      redirect_to @milestone
    end
  end

  private
  def milestone_params
    params.require(:milestone).permit(:title,:due_date,:description,:status, :icon, :created_at, :updated_at)
  end
end
