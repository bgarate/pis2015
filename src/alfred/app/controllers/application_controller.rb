class ApplicationController < ActionController::Base

  before_action :loged?
  before_action :admin?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def loged?
    @user = current_user
    if not @user
        redirect_to root_path
    end
  end

  def admin?
    @user = current_user
    if @user
      @person = Person.find(@user.person_id)
      if !(@person.admin)
        redirect_to root_path
      end
    end
  end

  helper_method :current_user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if (session[:user_id]) && (!(User.find_by(id: session[:user_id]).oauth_expired?))
  end

end
