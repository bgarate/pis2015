require 'rails_helper'

describe MilestonesController, "Milestone Controller" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  before do
    @m1 = Milestone.new :title=>'Entrega del prototipo de alfred', :description=>'Hay que entregar el protipo de alfred
                                  a la gente de pis. Ademas de cafe y galletitas maria gratis'
    @m1.due_date= Time.now - (3*2*7*24*60*60)
    @m1.milestone_type = :feedback
    @m1.status=0
    @m1.save!

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

  it "Deveria modificar el status a done" do
    put :update, :id => @m1.id, :milestone => { :status => :done }
    @m1.reload
    expect(@m1.status).to eq "done"
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
      get :index
      expect(response.status).to eq(200)
    end

    it 'creates a milestone' do
      post :new
      post :create, {:milestone=>{:title=>'milestone1', :description=>'unadescripcionde1'}}
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

    it 'no muestra la milestone' do
      session[:user_id] = @no_ad_user.id
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

      expect(response).to redirect_to(people_path)
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

end

