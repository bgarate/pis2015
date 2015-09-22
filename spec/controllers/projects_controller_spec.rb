require 'rails_helper'

describe ProjectsController do

  before do
    # Creo una persona de tipo administrador
    @admin = Person.new :name=>'NombreAdmin', :email=>'mail@admin.com', :admin=>true
    @admin.save!
    # Creo un usuario asociado a dicha persona
    @ad_user = User.new :person => @admin
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @ad_user.oauth_expires_at = Time.current().advance(days:1)
    @ad_user.save!
    # Creo una persona que NO es administrador
    @no_admin = Person.new :name=>'NombreNoAdmin', :email=>'mail@noadmin.com', :admin=>false
    @no_admin.save!
    # Creo un usuario asociado a dicha persona
    @no_ad_user = User.new :person => @no_admin
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @no_ad_user.oauth_expires_at = Time.current().advance(days:1)
    @no_ad_user.save!
  end

  describe "GET new" do
    it "Despliega formulario de creacion de proyecto" do
      session[:user_id] = @ad_user.id
      get :new, :session => session
      # Espero que me muestre el formulario
      expect(response).to render_template("new")
    end

    it "No deberia desplegar el formulario si el usuario no es admin" do
      session[:user_id] = @no_ad_user.id
      get :new, :session => session
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

  end

  describe "GET create" do
    it "Crea proyecto con nombre, mail y cliente valido" do
      session[:user_id] = @ad_user.id
      get :create, {:project=>{:name=>'Nombre', :client=>'Cliente', :status=>"active"},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it "No crea proyecto con cliente vacio" do
      session[:user_id] = @ad_user.id
      get :create, {:project=>{:name=>'Nombre', :status=>"inactive"},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

  end

end