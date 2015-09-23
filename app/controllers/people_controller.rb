class PeopleController < ApplicationController

  skip_before_action :admin?, only:[:show, :index, :me]

  def index
    u = User.find_by(id: session[:user_id])
    redirect_to action: 'show', id: u.person_id
  end

  def me
    redirect_to(:action => "index") and return
  end

  def show
    person = Person.find_by(id: params[:id])

    if person
      #nombre
      @name = person.name

      #rol tecnico
      @trole = ''
      @trole = person.tech_role.name if person.tech_role

      #habilidades
      @skills = person.skills

      #proyectos
      @proysin = person.projects.where("Projects.end_date IS NULL OR Projects.end_date >= CURRENT_DATE").length
      @proysend = person.projects.where("Projects.end_date < CURRENT_DATE").length

      #tiempo en moove-it
      @start_date = person.start_date
      #Eventos (Hitos)
      @events = person.milestones.where("milestones.due_date >= CURRENT_DATE AND milestones.status = 0 AND milestones.milestone_type = 1")
      #Hitos pendientes
      @overcomes = person.milestones.where("milestones.due_date < CURRENT_DATE AND milestones.status = 0")
      #Todos los hitos
      @milestones = person.milestones
    else
      redirect_to root_path
    end
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.save
    if @person.valid?
      flash.notice = "'#{person_params[:name]}' creado con éxito!"
      redirect_to @person
    else
      flash.alert = "'#{person_params[:name]}' no se ha podido crear"
      redirect_to '/people/new'
    end
  end

  def assign_milestone
    @milestone=Milestone.find(params[:milestone_id])
    @person=Person.find(params[:person_id])
    @person.milestones<<@milestone
    redirect_to me_people_path
  end

  def show_milestones
    @person=Person.find(params[:person_id])
  end


  private

  def person_params
    params.require(:person).permit(:name, :email, :cellphone, :phone, :birth_date, :start_date)
  end


end
