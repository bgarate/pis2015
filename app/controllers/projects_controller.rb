class ProjectsController < ApplicationController

  before_action :get_project, only: [:show, :edit, :update, :destroy]
  skip_before_action :admin?, only: [:show, :assign_person]

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

    respond_to do |f|
      f.json { render json: name_and_path(@projects)}
      f.html { render }
    end

  end

  def show
    person = Person.find(current_user.person_id)
    if !(person.admin) then
      usuarios = [person]
      if !person.mentees.empty?
        usuarios = usuarios + person.mentees.all
      end
    else
      usuarios = Person.all
    end
    @usr = []
    usuarios.each  do |u|
      if !(@project.people.exists?(u.id))
        @usr = @usr + [u]
      end
    end
  end

  def new
    @technologies = Technology.all
  end

  def create
    @project = Project.new(project_params)
    @project.technology_ids = params[:technologies]
    @project.save
    if @project.valid?
      redirect_to @project
    else
      redirect_to '/projects/new'
    end
  end

  def edit
    @technologies = Technology.all
    tech_aux = @project.technologies
    @selected_tech = []
    tech_aux.each do |t|
      @selected_tech<<t.id
    end
  end

  def update
    @project.technology_ids = params[:technologies]
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
    if ! project.people.exists?(person.id)
      project.people<< person
      project.save
    end
    redirect_to project
  end

  private
  def project_params
    params.require(:project).permit(:name, :client, :status, :start_date, :end_date)
  end


  def name_and_path (project)
    project.map do |p|
      {"name" => p.name, "url" => project_path(p)}
    end
  end


end