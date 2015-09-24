require 'rails_helper'

describe PeopleController do

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
    it "Despliega formulario de creacion de usuario" do
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

    it "Deveria redirigir a index" do
      admin = Person.new :name=>'NombreAdmin', :email=>'mail@admin.com', :admin=>true
      admin.save!

      ad_user = User.new :person => admin
      ad_user.oauth_expires_at = Time.current().advance(days:1)
      ad_user.save!
      session[:user_id] = ad_user.id

      get :me
      expect(response).to redirect_to(:action => "index")
    end
  end

  describe "GET create" do
    it "Crea usuario con nombre y mail valido" do
      session[:user_id] = @ad_user.id
      get :create, {:person=>{:name=>'Nombre', :email=>'mail@example.com'},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it "No crea usuario con mail vacio" do
      session[:user_id] = @ad_user.id
      get :create, {:person=>{:name=>'Nombre'},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

  end

  describe "add_mentor"do
    it "No deberia desplegar el formulario si el usuario no es admin" do
      session[:user_id] = @no_ad_user.id

      get :add_mentor_form ,{:mentee_id => 1}, :session => session
      # Espero ser redirigido
      expect(response).to redirect_to root_path
    end

    it "Debería dar error si mentee y mentor son el mismo" do
      session[:user_id] = @ad_user.id
      get :add_mentor,{:mentee_id => 1, :mentor_id=>1, :start_date => Date.today()},:session => session
      expect(response.status).to eq(500)

    end

    it "Deberia dar error si la relacion mentee-mentor ya existe" do
      session[:user_id] = @ad_user.id
      get :add_mentor,{:mentee_id => @admin.id, :mentor_id=>@no_admin.id ,:start_date => Date.today},:session => session
      get :add_mentor,{:mentee_id => @admin.id, :mentor_id=>@no_admin.id, :start_date => Date.today},:session => session
      expect(response.status).to eq(500)

    end

    it "Deberia redirigirme a mentee si todo ok" do
      session[:user_id] = @ad_user.id
      get :add_mentor,{:mentee_id => @no_admin.id, :mentor_id=>@admin.id ,:start_date => Date.today},:session => session
      expect(response).to redirect_to(@no_admin)
    end

  end
end