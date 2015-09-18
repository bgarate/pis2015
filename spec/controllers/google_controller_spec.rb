require 'rails_helper'

describe GoogleController, "Login a traves de google oatuh" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  it "Deveria guardar el id del usuario logueado en session y redirigir perfil" do
    tr = TechRole.new
    tr.name= "Vendedor de Tortas Fritas"
    tr.save!

    per = Person.new :name=>'Alfred', :email=>'alfred.pis.2015@gmail.com'
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

    pro = Project.new
    pro.name= 'Super Tortas 0.1'
    pro.start_date= Time.now - (2*7*24*60*60)
    pro.end_date= Time.now - (2*7*24*60*60)
    per.projects<<(pro)

    per.save!

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit '/auth/google_oauth2/callback'
    expect(current_path).to include(people_path)

  end

  it "Deveria redirigir a unregistered" do

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit '/auth/google_oauth2/callback'

    expect(current_path).to eq google_unregistered_path
  end

  it "Deveria poner el user id en session en nil y redirigir a home" do
    admin = Person.new :name=>'NombreAdmin', :email=>'mail@admin.com', :admin=>true
    admin.save!

    ad_user = User.new :person => admin
    ad_user.oauth_expires_at = Time.current().advance(days:1)
    ad_user.save!
    session[:user_id] = ad_user.id

    get :signout
    expect(session[:user_id]).to be_nil
    expect(response).to redirect_to(root_path)
  end

  it "Deveria renderizar unregistered con msj como parametro" do
    get :unregistered
    expect(assigns(:msj)).to eq('Usuario no regitrado, contacte a un administrador.')
    expect(response).to render_template('unregistered')
  end

  it "Deveria redireccionar a root path por no estar logueado" do
    get :signout
    expect(response).to redirect_to(root_path)
  end

end