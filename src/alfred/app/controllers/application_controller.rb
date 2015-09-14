class ApplicationController < ActionController::Base

  before_action :admin?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin?
    @user = current_user
    @person = Person.find(@user.person_id)
    if !(@person.admin)
      redirect_to(@person)
    end
  end

  helper_method :current_user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if (session[:user_id]) && (!(User.find_by(id: session[:user_id]).oauth_expired?))
  end

  helper_method :dayname
  def dayname(date)
    days = ['Dom', 'Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab']
    @dayname ||= days[date.wday]
  end

  helper_method :monthname
  def monthname(date)
    monthes = ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Setiembre', 'Octubre', 'Noviembre', 'Diciembre']
    @monthname ||= monthes[date.month]
  end
end
