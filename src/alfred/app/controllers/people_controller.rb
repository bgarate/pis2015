class PeopleController < ApplicationController

  skip_before_action :admin?, only:[:show]

  def index
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      id = user.person_id
      person = Person.find_by(id: id)
      if person
        #nombre
        @name = person.name

        #rol tecnico
        @trole = person.tech_role.name

        #habilidades
        @skills = person.skills

        #proyectos
        @proysin = person.projects.where("Projects.end_date IS NULL OR Projects.end_date >= CURRENT_DATE").length
        @proysend = person.projects.where("Projects.end_date < CURRENT_DATE").length

        #tiempo en moove-it
        @timein= ''
        if (Date.today.year - person.start_date.year) != 0
          if Date.today.year - person.start_date.year == 1
            @timein = @timein + "#{Date.today.year - person.start_date.year} año"
          else
            @timein = @timein + "#{Date.today.year - person.start_date.year} años"
          end
        end
        if @timein != ''
          @timein = @timein + ' y '
        end
        if (Date.today.year - person.start_date.year) != 0
          if ((Date.today.month - person.start_date.month).abs) == 1
            @timein = @timein + "#{(Date.today.month - person.start_date.month).abs} mes"
          else
            @timein = @timein + "#{(Date.today.month - person.start_date.month).abs} meses"
          end
        end
        #Eventos (Hitos)
        @events = person.milestones.where("milestones.due_date >= CURRENT_DATE AND milestones.status = 0 AND milestones.milestone_type = 1")
        #Hitos pendientes
        @overcomes = person.milestones.where("milestones.due_date < CURRENT_DATE AND milestones.status = 0")
        #Todos los hitos
        @milestones = person.milestones
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
  end

  def create
    @person = Person.new(person_params)
    @person.save
    if @person.valid?
      redirect_to @person
    else
      redirect_to '/people/new'
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :email, :cellphone, :phone, :birth_date, :start_date)
  end


end
