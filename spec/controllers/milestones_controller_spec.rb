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
    @m.status=0
    @m.icon = "test/silueta.gif"
    @m.save!

    request.env["HTTP_REFERER"] = root_path
  end

  before do

    @c1 = Category.new :name=>'Feedback', :icon=>'unicono'
    @c1.created_at=Time.now
    @c1.updated_at=Time.now
    @c1.save!

    @cFeed = Category.new :name=>'Feedback cualquiera', :icon=>'unicono'
    @cFeed.is_feedback=true
    @cFeed.save!

    @m1 = Milestone.new :title=>'Entrega del prototipo de alfred', :description=>'Hay que entregar el protipo de alfred
                                  a la gente de pis. Ademas de cafe y galletitas maria gratis'
    @m1.due_date= Time.now - (3*2*7*24*60*60)
    @m1.category=@c1
    @m1.status=0
    @m1.save!


    @m2 = Milestone.new :title=>'Entrega del prototipo de alfred', :description=>'Hay que entregar el protipo de alfred
                                  a la gente de pis. Ademas de cafe y galletitas maria gratis'
    @m2.due_date= Time.now - (3*2*7*24*60*60)
    @m2.category=@c1
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
    session[:user_id] = @ad_user.id
    p1 = Person.new
    p1.name = "Juan Perez"
    p1.email ="juanperez1@gmail.com"
    p1.start_date =Time.now
    p1.save!
    cat1= Category.new
    cat1.name= 'feed'
    cat1.icon= '0asdsadsa'
    cat1.created_at=Time.now
    cat1.updated_at=Time.now
    cat1.save!
    cat2= Category.new
    cat2.name= 'newcat'
    cat2.icon= 'descripcion'
    cat2.created_at=Time.now
    cat2.updated_at=Time.now
    cat2.save!
    @m1.category=cat2
    @m1.save!
    get :edit, :id => @m1.id
    put :update, :id => @m1.id,:category_id=>cat1.id, :milestone => { :status => :done, :category_id=>cat1.id}, :session=>session
    @m1.reload
    expect(@m1.status).to eq "done"
  end

  it "Deberia modificar el status al siguiente (done)" do
    session[:user_id] = @ad_user.id
    get :next_status, :milestone_id => @m1.id, :session=>session
    @m1.reload
    expect(@m1.status).to eq "done"
  end

  it "Deberia modificar el status a pending (from done)" do
    session[:user_id] = @ad_user.id
    @m1.status= 'done'
    @m1.save!
    get :next_status, :milestone_id => @m1.id, :session=>session
    @m1.reload
    expect(@m1.status).to eq 'pending'
  end

  it "Deberia modificar el status a reject" do
    session[:user_id] = @ad_user.id
    get :next_status_rej, :milestone_id => @m1.id, :session=>session
    @m1.reload
    expect(@m1.status).to eq 'rejected'
  end

  it "Deberia modificar el status a pending (from rejected)" do
    session[:user_id] = @ad_user.id
    @m1.status= 'rejected'
    @m1.save!
    get :next_status_rej, :milestone_id => @m1.id, :session=>session
    @m1.reload
    expect(@m1.status).to eq 'pending'
  end

  it "No deberia modificar el nombre" do
    session[:user_id] = @ad_user.id
    put :update, :id => @m1.id, :milestone => { :title => '' , :category_id=>@c1.id}
    @m1.reload
    expect(response).to render_template('edit')
  end


  it "añade un revisor a un hito de tipo feedback" do
    session[:user_id] = @ad_user.id
    put :update, :id => @m1.id, :category_id=>@cFeed.id, :milestone => {:category_id=>@cFeed.id, :feedback_author_id => @person.id }
    @m1.reload
    expect(@m1.feedback_author).to eq @person
    expect(@m1.people).to include(@person)
  end

  it "no añade un revisor a un hito que no es tipo feedback" do
    session[:user_id] = @ad_user.id
    put :update, :id => @m2.id, :milestone => {:feedback_author =>  @person , :category_id=>@c1.id}
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
      session[:user_id] = @ad_user.id
      p1 = Person.new
      p1.name = "Juan Perez"
      p1.email ="juanperez1@gmail.com"
      p1.start_date =Time.now
      p1.save!
      p2 = Person.new
      p2.name = "Juan2 Perez"
      p2.email ="juanperez2@gmail.com"
      p2.start_date =Time.now
      p2.save!
      p3 = Person.new
      p3.name = "Juan3 Perez"
      p3.email ="juanperez3@gmail.com"
      p3.start_date =Time.now
      p3.save!

      get :new
      post :create, :person_id=>@admin.id, :milestone=>{:title=>'milestone1', :description=>'unadescripcionde1',:category_id =>@c1.id},
                      :people=>[p1.id,p2.id,p3.id]
      expect(response.status).to eq(302)

    end

    it 'creates a milestone no admin' do
      session[:user_id] = @no_ad_user.id
      p1 = Person.new
      p1.name = "Juan Perez"
      p1.email ="juanperez1@gmail.com"
      p1.start_date =Time.now
      p1.save!
      p2 = Person.new
      p2.name = "Juan2 Perez"
      p2.email ="juanperez2@gmail.com"
      p2.start_date =Time.now
      p2.save!
      p3 = Person.new
      p3.name = "Juan3 Perez"
      p3.email ="juanperez3@gmail.com"
      p3.start_date =Time.now
      p3.save!

      get :new
      post :create, :person_id=>@admin.id, :milestone=>{:title=>'milestone1', :description=>'unadescripcionde1',:category_id =>@c1.id},
           :people=>[p1.id,p2.id,p3.id]
      expect(response.status).to eq(302)

    end

    it 'creates a milestone no person param' do
      session[:user_id] = @no_ad_user.id
      p1 = Person.new
      p1.name = "Juan Perez"
      p1.email ="juanperez1@gmail.com"
      p1.start_date =Time.now
      p1.save!
      p2 = Person.new
      p2.name = "Juan2 Perez"
      p2.email ="juanperez2@gmail.com"
      p2.start_date =Time.now
      p2.save!
      p3 = Person.new
      p3.name = "Juan3 Perez"
      p3.email ="juanperez3@gmail.com"
      p3.start_date =Time.now
      p3.save!

      get :new
      post :create, :redirect_url => root_path, :milestone=>{:title=>'milestone1', :description=>'unadescripcionde1',:category_id =>@c1.id},
           :people=>[]
      expect(response.status).to eq(302)

    end

    it 'creates a milestone people nil' do
      session[:user_id] = @no_ad_user.id
      p1 = Person.new
      p1.name = "Juan Perez"
      p1.email ="juanperez1@gmail.com"
      p1.start_date =Time.now
      p1.save!
      p2 = Person.new
      p2.name = "Juan2 Perez"
      p2.email ="juanperez2@gmail.com"
      p2.start_date =Time.now
      p2.save!
      p3 = Person.new
      p3.name = "Juan3 Perez"
      p3.email ="juanperez3@gmail.com"
      p3.start_date =Time.now
      p3.save!

      get :new
      post :create, :person_id=> nil, :redirect_url => root_path, :milestone=>{:title=>'milestone1', :description=>'unadescripcionde1',:category_id =>@c1.id},
           :people=>nil
      expect(response.status).to eq(302)

    end

    it 'is valid with a title and description' do
      session[:user_id] = @ad_user.id
      post :create, :person_id=>@admin.id, :milestone=>{:title=>'Milestone1', :description=>'unadescripciondemilestone', :category_id=>@c1.id}
      expect(response.status).to eq(302)
    end

    #GOOGLE CALENDAR
    it 'crete milsteones with dates' do

      auth = double()
      allow(auth).to receive(:access_token=).and_return('')

      servaux = double()
      allow(servaux).to receive(:insert).and_return('')
      serv = double()
      allow(serv).to receive(:events).and_return(servaux)

      cli = double()
      allow(cli).to receive(:authorization).and_return(auth)
      allow(cli).to receive(:execute).with(anything()).and_return('')
      allow(cli).to receive(:discovered_api).with(anything(),anything()).and_return(serv)


      Google::APIClient.stub(:new) { cli }

      session[:user_id] = @ad_user.id
      post :create, :person_id=>@admin.id, :milestone=>{:title=>'Milestone1', :description=>'unadescripciondemilestone', :category_id=>@c1.id, :start_date=> Time.now - 5.days, :due_date=> Time.now}
      expect(response.status).to eq(302)
    end

    it 'is invalid without a title' do
      session[:user_id] = @ad_user.id
      post :create, :person_id=>@admin.id, :milestone=>{ :description=>'unadescripciondemilestone', :category_id=>@c1.id}
      expect(response).to redirect_to(@admin)
    end

    it 'is invalid without a description' do
      session[:user_id] = @ad_user.id
      get :create, :person_id=>@admin.id, :milestone=>{:title=>'Milestone1', :category_id=>@c1.id}
      expect(response.status).to redirect_to(@admin)
    end

    it 'modifica el hito' do
      session[:user_id] = @ad_user.id
      p1 = Person.new
      p1.name = "Juan Perez"
      p1.email ="juanperez1@gmail.com"
      p1.start_date =Time.now
      p1.save!
      get :edit, :id => @m1.id
      put :update, :id => @m1.id, :milestone => { :status => :done, :category_id=>@c1.id }, :people=>[p1.id]
      @m1.reload
    end

    it 'deberia asignar una categoria' do
      session[:user_id] = @ad_user.id
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

  describe 'Notes' do
    it 'despliega la nota' do
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
      m1.notes.create({:text=> 'una nota pa borrar'})

      get :show, :id => m1.id, :session=>session
      expect(response).to render_template("show")
    end
  end


  describe "permisos" do
    it 'Deberia renderizar show' do
      get :show, :id => @m.id
      expect(response.status).to eq(200)
    end

    it 'Deberia renderizar edit por ser mentor' do
      @no_ad_user.person.mentees<<(@ad_user.person)
      @no_ad_user.save!
      @ad_user.person.milestones<<(@m1)
      @ad_user.save!
      session[:user_id] = @no_ad_user.id
      get :edit, :id => @m1.id, :category_id=>@c1.id
      expect(response.status).to eq(200)
    end



  end

end

