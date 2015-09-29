require 'rails_helper'
require 'rubygems'
require 'google/api_client'
require 'google_drive'
require 'rspec/active_model/mocks'

describe GoogleController, "Login a traves de google oatuh" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
    allow_any_instance_of(ApplicationController).to receive(:can_view_person?) { true }
  end

  #
  # LOGIN CON GOOGLE Y OAUTH2
  #
  it 'Deberia guardar el id del usuario logueado en session y redirigir perfil' do

    tr = TechRole.new
    tr.name= 'Vendedor de Tortas Fritas'
    tr.save!

    per = Person.new :name=>'Alfred', :email=>'alfred.pis.2015@gmail.com', :start_date=>Time.current()
    per.birth_date= Time.new(2012, 8, 29, 22, 35, 0)
    per.start_date= Time.new(2012, 8, 29, 22, 35, 0)
    per.tech_role = tr

    m = Milestone.new
    m.title = 'Conferencia Tecnológica'
    m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas. Ademas de cafe y galletitas maria gratis'
    m.due_date= Time.now + (3*2*7*24*60*60)
    m.milestone_type= 1
    m.status=0
    per.milestones<<(m)

    m1 = Milestone.new
    m1.title = 'Entrega del prototipo de alfred'
    m1.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
    m1.due_date= Time.now - (3*2*7*24*60*60)
    m1.status=0
    per.milestones<<(m1)

    sk1 = Skill.new
    sk1.name='angular'
    sk1.icon='skills/angular.png'
    sk2 = Skill.new
    sk2.name='java'
    sk2.icon='skills/java.png'
    per.skills<<(sk1)
    per.skills<<(sk2)

    pro = Project.new :name=>'Super Tortas 0.1', :client=> 'ATU', :status=> "active"
    pro.start_date= Time.now - (2*7*24*60*60)
    pro.end_date= Time.now - (2*7*24*60*60)
    pro.save!
    per.projects<<(pro)

    per.save!

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit '/auth/google_oauth2/callback'
    expect(current_path).to include(people_path)

  end


  it 'Deveria redirigir a unregistered' do

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit '/auth/google_oauth2/callback'

    expect(current_path).to eq google_unregistered_path
  end


  it 'Deberia poner el user id en session en nil y redirigir a home' do
    admin = Person.new :name=>'NombreAdmin', :email=>'mail@admin.com', :start_date=>Time.current(), :admin=>true

    admin.save!

    ad_user = User.new :person => admin
    ad_user.oauth_expires_at = Time.current().advance(days:1)
    ad_user.save!
    session[:user_id] = ad_user.id

    get :signout
    expect(session[:user_id]).to be_nil
    expect(response).to redirect_to(root_path)
  end


  it 'Deberia renderizar unregistered con msj como parametro' do

    get :unregistered
    expect(assigns(:msj)).to eq('Usuario no regitrado, contacte a un administrador.')
    expect(response).to render_template('unregistered')
  end


  it 'Deberia redireccionar a root path por no estar logueado' do
    get :signout
    expect(response).to redirect_to(root_path)
  end

  #
  # GOOGLE DRIVE
  #
  it 'Deveria mostrar la vista para agregar un documento' do
    tr = TechRole.new
    tr.name= 'Vendedor de Tortas Fritas'
    tr.save!

    per = Person.new :name=>'Alfred', :email=>'alfred.pis.2015@gmail.com', :start_date=>Time.current()
    per.birth_date= Time.new(2012, 8, 29, 22, 35, 0)
    per.start_date= Time.new(2012, 8, 29, 22, 35, 0)
    per.tech_role = tr

    m = Milestone.new
    m.title = 'Conferencia Tecnológica'
    m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas. Ademas de cafe y galletitas maria gratis'
    m.due_date= Time.now + (3*2*7*24*60*60)
    m.milestone_type= 1
    m.status=0
    per.milestones<<(m)

    per.save!

    get :adddriveview, :milestone_id => m.id
    expect(response).to render_template('adddriveview')
  end

  it 'Deveria redirigir a root path' do
    get :adddriveview
    expect(response).to redirect_to(root_path)
  end

  it 'Deveria redirigir a root path ' do
    get :driveerror
    expect(response).to redirect_to(root_path)
  end

  it 'Deveria redirigir a home y haber asociado el resource al hito' do

    f = double()
    allow(f).to receive(:resource_id).and_return('unid')
    allow(f).to receive(:title).and_return('untitulo')
    allow(f).to receive(:human_url).and_return('/una/url')

    s = double()
    allow(s).to receive(:file_by_url).with(anything()).and_return(f)

    GoogleDrive.stub(:login_with_oauth).with(anything()) { s }

    tr = TechRole.new
    tr.name= 'Vendedor de Tortas Fritas'
    tr.save!

    per = Person.new :name=>'Alfred', :email=>'alfred.pis.2015@gmail.com', :start_date=>Time.current()
    per.birth_date= Time.new(2012, 8, 29, 22, 35, 0)
    per.start_date= Time.new(2012, 8, 29, 22, 35, 0)
    per.tech_role = tr

    m = Milestone.new
    m.title = 'Conferencia Tecnológica'
    m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas. Ademas de cafe y galletitas maria gratis'
    m.due_date= Time.now + (3*2*7*24*60*60)
    m.milestone_type= 1
    m.status=0
    per.milestones<<(m)

    per.user = User.new
    per.user.oauth_token = 'UnToken'
    per.user.oauth_expires_at = Time.current().advance(days:1)

    per.save!
    session[:user_id] = per.user.id

    get :adddrive, :milestone_id => m.id, :URL => '/una/url'
    expect(response).to redirect_to(root_path)
    mr = Milestone.find_by(id: m.id)
    expect(mr.resources[0].url).to eq('/una/url')
  end

  it 'Deveria redirigir a home la pagina de error' do

    s = double()
    allow(s).to receive(:file_by_url).with(anything()) { raise Google::APIClient::ClientError }

    GoogleDrive.stub(:login_with_oauth).with(anything()) { s }

    tr = TechRole.new
    tr.name= 'Vendedor de Tortas Fritas'
    tr.save!

    per = Person.new :name=>'Alfred', :email=>'alfred.pis.2015@gmail.com', :start_date=>Time.current()
    per.birth_date= Time.new(2012, 8, 29, 22, 35, 0)
    per.start_date= Time.new(2012, 8, 29, 22, 35, 0)
    per.tech_role = tr

    m = Milestone.new
    m.title = 'Conferencia Tecnológica'
    m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas. Ademas de cafe y galletitas maria gratis'
    m.due_date= Time.now + (3*2*7*24*60*60)
    m.milestone_type= 1
    m.status=0
    per.milestones<<(m)

    per.user = User.new
    per.user.oauth_token = 'UnToken'
    per.user.oauth_expires_at = Time.current().advance(days:1)

    per.save!
    session[:user_id] = per.user.id

    get :adddrive, :milestone_id => m.id, :URL => '/una/url'
    expect(response).to redirect_to(google_driveerror_path(err: true))
  end

end