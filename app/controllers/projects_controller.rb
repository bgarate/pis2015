class ProjectsController < ApplicationController

  before_action :get_project, only: [:show, :edit, :update, :destroy]

  def get_project
    @project = Project.find(params[:id])
  end

  def index
  end

  def show
  end

  def new
  end

  def create
    @project = Project.new(project_params)
    @project.save
    if @project.valid?
      redirect_to @project
    else
      redirect_to '/projects/new'
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def project_params
    params.require(:project).permit(:name, :client, :status, :technologies, :start_date, :end_date)
  end

end