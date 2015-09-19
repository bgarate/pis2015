class ProjectsController < ApplicationController

  before_action :get_project, only: [:edit, :update, :destroy]

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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def project_params
    params.require(:project).permit(:name, :client, :status, :technologies, :start_date, :end_date)
  end

end