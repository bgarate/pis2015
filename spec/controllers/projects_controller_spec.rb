require 'rails_helper'

describe ProjectsController do

  before do
    # Creo una persona de tipo administrador
    @admin = Person.new :name=>'NombreAdmin', :email=>'mail@admin.com', :start_date=>Time.current(), :admin=>true
    @admin.save!
    # Creo un usuario asociado a dicha persona
    @ad_user = User.new :person => @admin
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @ad_user.oauth_expires_at = Time.current().advance(days:1)
    @ad_user.save!
    # Creo una persona que NO es administrador
    @no_admin = Person.new :name=>'NombreNoAdmin', :email=>'mail@noadmin.com', :start_date=>Time.current(), :admin=>false
    @no_admin.save!
    # Creo un usuario asociado a dicha persona
    @no_ad_user = User.new :person => @no_admin
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @no_ad_user.oauth_expires_at = Time.current().advance(days:1)
    @no_ad_user.save!

    # Creo un proyecto
    @proy = Project.new :name=>'Nombre', :client=>'Cliente', :status=>"active"
    @proy.save!
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
    it "Crea proyecto con nombre, estado y cliente valido" do
      session[:user_id] = @ad_user.id
      get :create, {:project=>{:name=>'Nombre', :client=>'Cliente', :status=>"active", :id_technologies=>[]},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it "No crea proyecto con cliente vacio" do
      session[:user_id] = @ad_user.id
      get :create, {:project=>{:name=>'Nombre', :status=>"inactive", :id_technologies=>[]},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

  end

  describe "GET update" do
    it "Actualiza proyecto con nombre, estado y cliente valido" do
      session[:user_id] = @ad_user.id
      get :update, {:id=>@proy.id, :project=>{:name=>'Nombre', :client=>'Cliente', :status=>"active", :technologies=>[]},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it "No crea proyecto con cliente vacio" do
      session[:user_id] = @ad_user.id
      get :update, {:id=>@proy.id, :project=>{:name=>'Nombre', :client=>'', :status=>"inactive", :technologies=>[]},:session=>session}
      # Espero que no se modifique el cliente
      expect(@proy.client).to eq('Cliente')
    end

  end

  describe "GET show" do
    it "Muestra un proyecto" do
      session[:user_id] = @ad_user.id
      get :show, {:id=>@proy.id}
      # Espero ser redirigido
      expect(response).to render_template("show")
    end
    describe "GET show" do
      it "Muestra un proyecto" do
        session[:user_id] = @no_ad_user.id
        get :show, {:id=>@proy.id}
        # Espero ser redirigido
        expect(response).to render_template("show")
      end
    end
    describe "assign_project" do
      it "Asigna una persona a un proyecto" do
        session[:user_id] = @ad_user.id
        p1= Project.new
        p1.name="projecto prueba"

        post :assign_person, :project_id => p1.id, :person_id=> @admin.id, :session=>session
        # Espero ser redirigido
        expect(response.status).to eq(302)
      end
    end

    describe "GET Destroy" do
    it "Borra logicamente un proyecto" do
      session[:user_id] = @ad_user.id
      get :destroy, {:id=>@proy.id}
      # Espero que boore logicamente el proyecto
      expect(@proy.validity).to eq(true)
    end

    it "Deberia redireccionarme si el proyecto fue eliminado" do
      session[:user_id] = @ad_user.id
      get :destroy, {:id=>-1}
      # Espero que me redireccione
      expect(response.status).to eq(302)
    end
  end

  end
end

