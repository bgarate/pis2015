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
      @identifier = person.id

      #admin?
      @admin = person.admin

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
      #Todos los hitos
      @mentorships = person.mentors
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

  def add_mentor
    if (params[:mentor_id] != params[:mentee_id])
      @mentor=Person.find(params[:mentor_id])
      @mentee=Person.find(params[:mentee_id])
      @mentor.mentees_assignations.create! start_date: params[:start_date], mentee: @mentee
      redirect_to @mentee
    end
  end

  def add_mentor_form
    @mentee=Person.find(params[:mentee_id])
    @posible_mentors=Person.all.where("id NOT IN (SELECT mentor_id FROM mentorships WHERE mentee_id=?) AND id<>?",params[:mentee_id], params[:mentee_id])
    render :file => "app/views/people/add_mentor_form"
  end


  private
  def person_params
    params.require(:person).permit(:name, :email, :cellphone, :phone, :birth_date, :start_date)
  end

end
