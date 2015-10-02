class ProjectsController < ApplicationController

  before_action :get_project, only: [:show, :edit, :update, :destroy]
  skip_before_action :admin?, only: [:show]

  def get_project
    @project = Project.find_by(id: params[:id])
    if !@project
      @project = Project.find_by(name: params[:id])
      if !@project
          @project = Project.find_by(client: params[:id])
      end
    end
    if !@project  || (! @project.validity?)
      redirect_to '/projects'
    end
  end

  def index
    @projects = Project.where(validity: 'true')
  end

  def show
    person = Person.find(current_user.person_id)
    if !(person.admin) then
      person.mentees.empty? ? @usr= [person] : @usr = person.mentees
    else
      @usr = Person.all
    end
  end

  def new
    @technologies = Technology.all
  end

  def create
    @project = Project.new(project_params)
    id_tec = (params.fetch :technologies)
    @project.technologies<<Technology.find(id_tec)
    @project.save
    if @project.valid?
      redirect_to @project
    else
      redirect_to '/projects/new'
    end
  end

  def edit
    @technologies = Technology.all
  end

  def update
    id_tec = (params.fetch :technologies)
    @project.technologies = Technology.find(id_tec)
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project.validity=false
    @project.save
    redirect_to '/projects'
  end

  def assign_person
    pj_id= params[:project_id]
    person_id= params[:person_id]
    project= Project.find(pj_id)
    person= Person.find(person_id)
    if not project.people.exists?(person.id)
      project.people<< person
      project.save
    end
    redirect_to project
  end


  private
  def project_params
    params.require(:project).permit(:name, :client, :status, :id_technologies, :start_date, :end_date)
  end

end