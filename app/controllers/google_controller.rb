  require 'pp'
  require 'rubygems'
  require 'google/api_client'
  require 'google_drive'

class GoogleController < ApplicationController

  skip_before_action :loged?, only:[:callback,:unregistered]
  skip_before_action :admin?

  #
  # Login con Google y OAuth2
  #
  def callback
    auth = env['omniauth.auth']

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
      redirect_to people_path
    else
      redirect_to google_unregistered_path
    end
  end

  def signout
    session[:user_id] = nil
    redirect_to root_path
  end

  def unregistered
    @msj = String.new('Usuario no regitrado, contacte a un administrador.')
  end

  #
  # Google Drive
  #
  def adddriveview
    @milestone_id = params[:milestone_id]
  end

  def adddrive
    url = params[:URL]
    @milestone_id = params[:milestone_id]
    m = Milestone.find_by(id: @milestone_id)
    u = current_user

    if m and u
      session = GoogleDrive.login_with_oauth(u.oauth_token)

      #Crear el archivo
      #out_file = File.new('adjunto.doc', 'w')
      #out_file.puts('')
      #out_file.close

      #Subirlo
      #session.upload_from_file('adjunto.odt', "adjuntoHitoNro#{@milestone_id}", :convert => true)

      #gurdar crear adjunto
      f = session.file_by_url(url)

      r = Resource.new
      r.doc_id= f.resource_id
      r.title= f.title
      r.url= f.human_url
      m.resources<<(r)
      m.save!

      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end