class ProjectsController < ApplicationController

  before_action :get_project, only: [:show, :edit, :update, :destroy]
  skip_before_action :admin?, only: [:show, :index, :assign_person]

  def get_project
    identifier = params[:id]
    @project = Project.find_by(id: identifier)
    unless @project
      identifier = identifier.downcase.gsub(/_/, "\s")
      @project = Project.where("lower(name)= :name", name:"#{identifier}").first
      unless @project
          @project = Project.where("lower(client)= :client", client:"#{identifier}").first
      end
    end
    unless @project  && @project.validity?
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
    unless (person.admin) then
      usuarios = [person]
      unless person.mentees.empty?
        usuarios = usuarios + person.mentees.all
      end
    else
      usuarios = Person.all
    end
    @usr = []
    usuarios.each  do |u|
      unless (@project.people.exists?(u.id))
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
      redirect_to '/projects/'
    else
      redirect_to '/projects/new'
    end
  end

  def edit
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

      event = AssignToProjectEvent.new(author: current_person, person: person, project: project)
      event.fire

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