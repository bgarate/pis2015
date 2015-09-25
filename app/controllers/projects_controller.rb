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
    id_tec = (params.fetch :project).fetch :id_technologies
    filtradas = id_tec.reject { |i| i.empty? }
    @project.technologies<<Technology.find(filtradas)
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
    id_tec = (params.fetch :project).fetch :technologies
    filtradas = id_tec.reject { |i| i.empty? }
    @project.technologies = Technology.find(filtradas)
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
=begin
    @project.destroy!
    redirect_to :index
=end
  end

  private
  def project_params
    params.require(:project).permit(:name, :client, :status, :id_technologies, :start_date, :end_date)
  end

end