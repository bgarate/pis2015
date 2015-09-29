class MilestonesController < ApplicationController

  before_action :get_milestone, only: [:add_category]
  before_action :get_milestone_by_id, only: [:update, :edit, :show, :destroy]
  before_action :get_category, only: [:add_category]
  before_action :is_authorized?, only: [:show,:destroy]
  skip_before_action :admin?, only: [:index, :show, :destroy]

  def is_authorized?
    @person=Person.find(current_user.person_id)
    if @person.mentees.exists?(@milestone.id)|| current_user_admin? || @person.milestones.exists?(@milestone.id)
    else
      flash.notice = t('not_authorized')
      redirect_to people_path
    end
  end

  def get_milestone
    @milestone=Milestone.find(params[:milestone_id])
  end

  def get_milestone_by_id
    @milestone=Milestone.find(params[:id])
  end

  def get_category
    @category=Category.find(params[:category_id])
  end

  def index
      @milestone= Milestone.all
  end

  def new
    @milestone=Milestone.new
  end

  def create
    @milestone=Milestone.new(milestone_params)
    @milestone.save
    if @milestone.valid?
      flash.notice = "'#{milestone_params[:title]}' creado con éxito!"
      redirect_to @milestone
    else
      flash.alert = "'#{milestone_params[:title]}' no se ha podido crear"
      redirect_to '/milestones/new'
    end

  end

  def add_category
    @category.milestones<<@milestone
    redirect_to @milestone
  end
  # Por ahora queda asi, deberia ser @milestone.category= @category

  def show
  end

  def destroy
    @milestone.notes.each do |n|
      n.destroy
    end
    milestone.destroy
    redirect_to milestones_path
  end
	
  def edit
    @tags = Tag.all
  end
	
  def update
    if @milestone.update_attributes(milestone_params)
      @milestone.tag_ids = params[:tags]
      redirect_to @milestone
    end
  end

  def next_status
    @milestone.status = @milestone.get_next_status
    @milestone.save!
    redirect_to :back
  end

  private
  def milestone_params
    params.require(:milestone).permit(:title, :start_date, :due_date,:description,:status, :icon, :created_at, :updated_at)
  end
end
