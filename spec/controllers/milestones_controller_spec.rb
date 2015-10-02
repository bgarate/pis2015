require 'rails_helper'

describe MilestonesController, "Milestone Controller" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }

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

    @m = Milestone.new
    @m.title = 'Conferencia Tecnológica'
    @m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas. Ademas de cafe y galletitas maria gratis'
    @m.due_date= Time.now + (3*2*7*24*60*60)
    @m.milestone_type= 1
    @m.status=0
    @m.icon = "test/silueta.gif"
    @m.save!

  end

  before do
    @m1 = Milestone.new :title=>'Entrega del prototipo de alfred', :description=>'Hay que entregar el protipo de alfred
                                  a la gente de pis. Ademas de cafe y galletitas maria gratis'
    @m1.due_date= Time.now - (3*2*7*24*60*60)
    @m1.milestone_type = :feedback
    @m1.status=0
    @m1.save!

    @c1 = Category.new :name=>'feedback', :icon=>'unicono'
    @c1.created_at=Time.now
    @c1.updated_at=Time.now
    @c1.save!


    @m2 = Milestone.new :title=>'Entrega del prototipo de alfred', :description=>'Hay que entregar el protipo de alfred
                                  a la gente de pis. Ademas de cafe y galletitas maria gratis'
    @m2.due_date= Time.now - (3*2*7*24*60*60)
    @m2.milestone_type = :event
    @m2.status=0
    @m2.save!

    @person = Person.new :name=>'noad', :email=>'noad@noadmin.com', :start_date=>Time.current(), :admin=>false
    @person.save!

    # Creo una persona de tipo administrador
    @admin = Person.new :name=>'NombreAdmin', :email=>'mail2@admin.com', :start_date=>Time.current(), :admin=>true
    @admin.save!
    # Creo un usuario asociado a dicha persona
    @ad_user = User.new :person => @admin
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @ad_user.oauth_expires_at = Time.current().advance(days:1)
    @ad_user.save!
    # Creo una persona que NO es administrador
    @no_admin = Person.new :name=>'NombreNoAdmin', :email=>'mail2@noadmin.com', :start_date=>Time.current(), :admin=>false
    @no_admin.save!
    # Creo un usuario asociado a dicha persona
    @no_ad_user = User.new :person => @no_admin
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @no_ad_user.oauth_expires_at = Time.current().advance(days:1)
    @no_ad_user.save!

  end

  it "Deberia modificar el status a done" do
    get :edit, :id => @m1.id
    put :update, :id => @m1.id, :milestone => { :status => :done }, @admin.name=>@admin.id
    @m1.reload
    expect(@m1.status).to eq "done"
  end

  it "Deberia modificar el status al siguiente" do
    get :next_status, :milestone_id => @m1.id
    @m1.reload
    expect(response).to redirect_to @m1
  end

  it "Deberia dar true" do
    m1=Milestone.new
    m1.title='miles'
    m1.description='desc'
    m1.milestone_type=:feedback
    m1.save!
    expect(m1.feedback?).to eq true
  end

  it "No deberia modificar el nombre" do
    put :update, :id => @m1.id, :milestone => { :title => '' }
    @m1.reload
    expect(response).to render_template('edit')
  end


  it "añade un revisor a un hito de tipo feedback" do
    put :update, :id => @m1.id, :milestone => {:feedback_author =>  @person }
    @m1.reload
    expect(@m1.feedback_author).to eq @person
  end

  it "no añade un revisor a un hito que no es tipo feedback" do
    put :update, :id => @m2.id, :milestone => {:feedback_author =>  @person }
    @m2.reload
    expect(@m2.feedback_author).to eq NIL
  end


  describe 'Milestone' do

    it 'has a 200 status code' do
      session[:user_id] = @ad_user.id
      get :index, :session=>session
      expect(response.status).to eq(200)
    end

    it 'has a 200 status code' do
      session[:user_id] = @no_ad_user.id
      get :index, :session=>session
      expect(response.status).to eq(200)
    end  

    it 'creates a milestone' do

      post :new
      post :create, {:milestone=>{:title=>'milestone1', :description=>'unadescripcionde1'}, :category_id =>@c1.id, @admin.name=>@admin.id}
      expect(response.status).to eq(302)

    end

    it 'is valid with a title and description' do
      get :create, {:milestone=>{:title=>'Milestone1', :description=>'unadescripciondemilestone', :due_date=>Time.now}}
      expect(response.status).to eq(302)
    end

    it 'is invalid without a title' do
      get :create, {:milestone=>{ :description=>'unadescripciondemilestone'}}
      expect(response).to redirect_to('/milestones/new')
    end
    it 'is invalid without a description' do
      get :create, {:milestone=>{:title=>'Milestone1'}}
      expect(response.status).to redirect_to('/milestones/new')
    end

    it 'deberia asignar una categoria' do
      cat1= Category.new
      cat1.name= 'feed'
      cat1.icon= '0asdsadsa'
      cat1.created_at=Time.now
      cat1.updated_at=Time.now
      cat1.save!

      m1 = Milestone.new
      m1.title ='Milestone for testing'
      m1.description='This is a milestone to test Milestones'
      m1.due_date=Time.now - 5.days
      m1.created_at= Time.now
      m1.updated_at= Time.now
      m1.status=1
      m1.icon= 'Icon'
      m1.save!
      post :add_category,{:milestone_id => m1.id, :category_id=>cat1.id},:session => session
      expect(response).to redirect_to(m1)

    end


    it 'muestra la milestone' do
        session[:user_id] = @ad_user.id
        m1 = Milestone.new
        m1.title ='Milestone for testing'
        m1.description='This is a milestone to test Milestones'
        m1.due_date=Time.now - 5.days
        m1.created_at= Time.now
        m1.updated_at= Time.now
        m1.status=1
        m1.icon= 'Icon'
        m1.save!

        get :show, :id => m1.id, :session=>session

        expect(response).to render_template("show")
    end

    it 'destruye la milestone' do
      session[:user_id] = @ad_user.id
      m1 = Milestone.new
      m1.title ='Milestone for testing'
      m1.description='This is a milestone to test Milestones'
      m1.due_date=Time.now - 5.days
      m1.created_at= Time.now
      m1.updated_at= Time.now
      m1.status=1
      m1.icon= 'Icon'
      m1.save
      m1.notes.create({:text=> 'una nota pa borrar'})


      delete :destroy, :id => m1.id, :session => session
      expect(response).to redirect_to('/milestones')

    end

    it 'no destruye la milestone' do
      session[:user_id] = @no_ad_user.id
      m1 = Milestone.new
      m1.title ='Milestone for testing'
      m1.description='This is a milestone to test Milestones'
      m1.due_date=Time.now - 5.days
      m1.created_at= Time.now
      m1.updated_at= Time.now
      m1.status=1
      m1.icon= 'Icon'
      m1.save
      m1.notes.create({:text=> 'una nota pa borrar'})


      delete :destroy, :id => m1.id, :session => session
      expect(response).to redirect_to('/people')

    end
  end

  describe "permisos" do
    it 'Deberia renderizar show por ser admin' do

      session[:user_id] = @ad_user.id
      get :show, :id => @m.id
      expect(response.status).to eq(200)
    end

    it 'Deberia renderizar  show por ser mentor' do
      @no_ad_user.person.mentees<<(@ad_user.person)
      @no_ad_user.save!
      @ad_user.person.milestones<<(@m)
      @ad_user.save!

      session[:user_id] = @no_ad_user.id
      get :show, :id => @m.id
      expect(response.status).to eq(200)
    end

    it 'Deberia redireccionar a root path por no ser admin ni mentor' do

      session[:user_id] = @no_ad_user.id
      get :show, :id => @m.id
      expect(response).to redirect_to root_path
    end

  end

end

