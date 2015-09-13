class ApplicationController < ActionController::Base

  before_action :admin?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin?
    @user = Person.find(:session[:user_id])
    if !@user.admin
      redirect_to(user)
    end
  end

end
