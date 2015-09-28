require 'rails_helper'

describe TagsController do

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

    @tag = Tag.new :name=>'NombreTag'
    @tag.save!

  end

  describe 'GET new' do
    it 'Despliega formulario de creacion de tag' do
      session[:user_id] = @ad_user.id
      get :new, :session => session
      # Espero que me muestre el formulario
      expect(response).to render_template("new")
    end

    it 'No debe desplegar el formulario de creación si el usuario no es admin' do
      session[:user_id] = @no_ad_user.id
      get :new, :session => session
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end
  end

  describe 'GET create' do
    it 'Crea tag con nombre' do
      session[:user_id] = @ad_user.id
      get :create, {:tag=>{:name=>'Nombre'},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it 'No crea con nombre vacío' do
      session[:user_id] = @ad_user.id
      get :create, {:tag=>{:name=>''},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end
  end

  describe 'GET show' do
    it 'Redirigir a root path' do
      session[:user_id] = @ad_user.id
      get :show, :id => 999999
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET update" do
    it "Actualiza tag con nombre" do
      session[:user_id] = @ad_user.id
      get :update, {:id=>@tag.id, :tag=>{:name=>'asdf'},:session=>session}
      # Espero ser redirigido
      expect(response.status).to eq(302)
    end

    it "No actualiza tag con nombre vacio" do
      session[:user_id] = @ad_user.id
      get :update, {:id=>@tag.id, :tag=>{:name=>''},:session=>session}
      # Espero que el nombre no haya sido modificiado
      expect(@tag.name).to eq('NombreTag')
    end
  end

  describe 'GET destroy' do
    it 'Destruye el tag' do
      session[:user_id] = @ad_user.id
      get :destroy, {:id=>@tag.id}
      # Espero ser redirigido
      expect(response).to redirect_to('/tags')
    end
  end

end