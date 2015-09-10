class GoogleController < ApplicationController
  def callback
    auth = env["omniauth.auth"]

    person = Person.find_by(email: auth.info.email)
    if person
      user =  User.find_by(person: person)
      if not user
        user = User.new
        user.person = person
      end
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!

      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to :controller => 'google', :action => 'unregistered'
    end
  end

  def signout
    session[:user_id] = nil
    redirect_to root_path
  end

  def unregistered
    @msj = String.new('Usuario no regitrado, contacte a un administrador.')
  end
end