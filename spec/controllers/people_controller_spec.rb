require 'rails_helper'

describe PeopleController do

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
  end


  describe "GET index" do
    it "Despliega el index" do
      session[:user_id] = @ad_user.id
      #get :index, :session => session
      get :index
      # Espero que me muestre el formulario
      expect(response).to render_template("index")
    end
  end


  describe "GET new" do
    it "Despliega formulario de creacion de usuario" do
      session[:user_id] = @ad_user.id
      get :new, :session => session
      # Espero que me muestre el formulario
      expect(response).to render_template("new")
    end

    it "No debe desplegar el formulario si el usuario no es admin" do
      session[:user_id] = @no_ad_user.id
      get :new, :session => session
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it "debe redirigir a index" do

      ad_user = User.new :person => @admin
      ad_user.oauth_expires_at = Time.current().advance(days:1)
      ad_user.save!
      session[:user_id] = ad_user.id
      get :me
      expect(response).to redirect_to(@admin)
    end
  end

  describe "GET create" do
    it "Crea usuario con nombre, fecha de ingreso y mail valido" do
      session[:user_id] = @ad_user.id
      get :create, {:person=>{:name=>'Nombre', :email=>'mail@example.com', :start_date=>Time.current()},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it "No crea usuario con mail vacio" do
      session[:user_id] = @ad_user.id
      get :create, {:person=>{:name=>'Nombre', :start_date=>Time.current()},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it "No crea usuario con nombre vacio" do
      session[:user_id] = @ad_user.id
      get :create, {:person=>{:email=>'mail@example.com', :start_date=>Time.current()},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it "No crea usuario con fecha de ingreso vacio" do
      session[:user_id] = @ad_user.id
      get :create, {:person=>{:name=>'Nombre', :email=>'mail@example.com'},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end
  end

  describe "GET show" do

      it 'Redirigir a root path' do
        session[:user_id] = @ad_user.id
        get :show, :id => 9999999999999
        expect(response).to redirect_to(root_path)
      end

      it 'Redirigir a root path' do
        session[:user_id] = 9999999999999
        get :show, :id => 9999999999999
        expect(response).to redirect_to('/welcome/index')
      end

      it 'Redirigir a root path' do
        p1 = Person.new :name=>"Juan Perez", :email=>"juanperez@gmail.com"
        p1.start_date =Time.now
        p1.save!
        session[:user_id] = p1.id
        get :show, :id => p1.id, :session=> session
        expect(response).to redirect_to('/welcome/index')
      end

      it 'Redirigir a root path' do
        allow_any_instance_of(ApplicationController).to receive(:admin?) { '' }
        allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }

        p1 = Person.new :name=>"Juan Perez", :email=>"juanperez@gmail.com"
        p1.start_date =Time.now
        p1.admin = true
        p1.save!

        session[:user_id] = @ad_user.id
        get :show_not_pending_timeline, :person_id => p1.id, :session=>session
        expect(response.status).to eq(200)
      end

  end

  describe "edit people" do
    it "deberia editar una persona" do
      session[:user_id] = @ad_user.id
      p1 = Person.new :name=>"Juan Perez", :email=>"juanperez@gmail.com"
      p1.start_date =Time.now
      p1.save!
      get :edit, :id=>p1.id
      put :update, :id => p1.id, :person =>{:name=> "Juano Perez"}, :session=>session
      p1.reload
      expect(response).to redirect_to(p1)
    end


  end


  describe "assign milestone" do

    it "deberia asignar una milestone" do
      session[:user_id] = @ad_user.id
      p1 = Person.new :name=>"Juan Perez", :email=>"juanperez@gmail.com"
      p1.start_date =Time.now
      p1.save!
      m1 = Milestone.new :title=>'Milestone for testing', :description=>'This is a milestone to test Milestones'
      m1.due_date=Time.now - 5.days
      m1.created_at= Time.now
      m1.updated_at= Time.now
      m1.status=1
      m1.icon= 'Icon'
      m1.save!

      post :assign_milestone, {:milestone_id=> m1.id, :person_id=>p1.id} , :session => session
      expect(response).to redirect_to("/people/#{p1.id}")

    end

  end

  describe "add_mentor" do
    it "No deberia desplegar el formulario si el usuario no es admin" do
      session[:user_id] = @no_ad_user.id
      post :add_mentor_form ,{:mentee_id => 1}, :session => session
      # Espero ser redirigido
      expect(response).to redirect_to root_path
    end

    it "Deberia desplegar el formulario si el usuario es admin" do
      session[:user_id] = @ad_user.id
      p1 = Person.new
      p1.name = "Juan Perez"
      p1.email ="juanperez2@gmail.com"
      p1.start_date =Time.now
      p1.save!
      post :add_mentor_form ,{:mentee_id => p1.id}, :session => session
      expect(response.status).to eq(200)
    end

    it "Debería dar error si mentee y mentor son el mismo" do
      session[:user_id] = @ad_user.id
      get :add_mentor,{:mentee_id => 1, :mentor_id=>1, :start_date => Date.today()},:session => session
      expect(response.status).to eq(422)
    end

    it "Deberia redirigir a mentee si la relacion mentee-mentor ya existe" do
      session[:user_id] = @ad_user.id
      get :add_mentor,{:mentee_id => @admin.id, :mentor_id=>@no_admin.id ,:start_date => Date.today},:session => session
      get :add_mentor,{:mentee_id => @admin.id, :mentor_id=>@no_admin.id, :start_date => Date.today},:session => session
      expect(response).to redirect_to(@admin)

    end

    it "Deberia redirigirme a mentee si todo ok" do
      session[:user_id] = @ad_user.id
      get :add_mentor,{:mentee_id => @no_admin.id, :mentor_id=>@admin.id ,:start_date => Date.today},:session => session
      expect(response).to redirect_to(@no_admin)
    end

  end

  describe "permisos" do
    it 'Deberia renderizar people show por ser admin' do
      session[:user_id] = @ad_user.id
      get :show, :id => @no_ad_user.person_id
      expect(response.status).to eq(200)
    end

    it 'Deberia renderizar people show por ser mentor' do
      @no_ad_user.person.mentees<<(@ad_user.person)
      @no_ad_user.save!
      session[:user_id] = @no_ad_user.id
      get :show, :id => @ad_user.person_id
      expect(response.status).to eq(200)
    end

    it 'Deberia redireccionar al perfil deseado apesar de no ser admin ni mentor' do
      p1=Person.new
      p1.name='fulano'
      p1.email='fulano@detal.com'
      p1.start_date=Time.now
      p1.save!
      session[:user_id] = @no_ad_user.id
      get :show, :id => p1.id
      expect(response.status).to eq(200)
    end
  end
end