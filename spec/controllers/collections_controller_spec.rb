require 'rails_helper'

describe CollectionsController, 'Collections Controller' do

  before do
    # Creo una persona de tipo administrador
    @admin = Person.new :name=>'NombreAdmin', :email=>'mail2@admin.com', :start_date=>Time.current(), :admin=>true
    @admin.save!
    # Creo un usuario asociado a dicha persona
    @ad_user = User.new :person => @admin
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @ad_user.oauth_expires_at = Time.current().advance(days:1)
    @ad_user.save!

    @c1 = Category.new :name=>'Feedback', :icon=>'unicono'
    @c1.created_at=Time.now
    @c1.updated_at=Time.now
    @c1.save!

    @t = Template.new
    @t.title= 'Inducción ruby'
    @t.description= 'Periodo en el cual son adquiridos los conocimientos subyacentes que implican el confort en el manejo de ruby como lenguaje de programación'
    @t.icon= 'glyphicon-flag'
    @t.category_id=@c1.id
    @t.save!

    @c = Collection.new
    @c.title = 'Induccion'
    @c.description = 'Hitos comunes en el periodo de induccion'
    @c.icon= 'glyphicon-flag'
    @c.collection_templates<<CollectionTemplate.new(:template=>@t, :days=>2)
    @c.save!

    request.env["HTTP_REFERER"] = root_path
  end

  it 'Deberia renderizar new' do
    session[:user_id] = @ad_user.id

    get :new
    expect(response).to render_template('new')
  end

  it 'Deberia renderizar index' do
    session[:user_id] = @ad_user.id

    get :index
    expect(response).to render_template('index')
  end

=begin
  it 'creates a collection' do
    session[:user_id] = @ad_user.id

    get :new
    post :create, :person_id=>@admin.id, :collection=>{:title=>'milestone1', :description=>'unadescripcionde1'}
    expect(response.status).to eq(302)

  end
=end

  it 'Show collection' do
    session[:user_id] = @ad_user

    get :show, :id=>@c.id
    expect(response).to render_template('show')
  end

  it 'Delete collection' do
    session[:user_id] = @ad_user.id

    get :destroy, :id=>@c.id
    expect(response).to redirect_to '/collections/'
  end

  it 'creates a milestone with auto drive atach' do
    a = double
    allow(a).to receive(:push).with(anything()).and_return('')

    f = double()
    allow(f).to receive(:resource_id).and_return('unid')
    allow(f).to receive(:title).and_return('untitulo')
    allow(f).to receive(:human_url).and_return('/una/url')
    allow(f).to receive(:copy).with(anything()).and_return(f)
    allow(f).to receive(:acl).and_return(a)

    s = double()
    allow(s).to receive(:file_by_url).with(anything()).and_return(f)

    GoogleDrive.stub(:login_with_oauth).with(anything()) { s }

    session[:user_id] = @ad_user.id

    r = Resource.new
    r.doc_id= '1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0'
    r.title= 'feedback'
    r.url= 'https://docs.google.com/document/d/1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0/edit'
    r.save!

    @t.resource_id=r.id
    @t.save!

    get :generate, :person_id=>@admin.id, :id=>@c.id
    expect(response.status).to eq(302)

  end

  it 'creates a milestone with auto drive atach without permissions' do

    s = double()
    allow(s).to receive(:file_by_url).with(anything()) { raise Google::APIClient::ClientError }

    GoogleDrive.stub(:login_with_oauth).with(anything()) { s }

    session[:user_id] = @ad_user.id

    r = Resource.new
    r.doc_id= '1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0'
    r.title= 'feedback'
    r.url= 'https://docs.google.com/document/d/1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0/edit'
    r.save!

    @t.resource_id=r.id
    @t.save!

    get :generate, :person_id=>@admin.id, :id=>@c.id
    expect(response.status).to eq(302)
  end

  it 'creates a milestone with auto drive atach inavalid url 1' do

    s = double()
    allow(s).to receive(:file_by_url).with(anything()) { raise GoogleDrive::Error }

    GoogleDrive.stub(:login_with_oauth).with(anything()) { s }

    session[:user_id] = @ad_user.id

    r = Resource.new
    r.doc_id= '1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0'
    r.title= 'feedback'
    r.url= 'https://docs.google.com/document/d/1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0/edit'
    r.save!

    @t.resource_id=r.id
    @t.save!

    get :generate, :person_id=>@admin.id, :id=>@c.id
    expect(response.status).to eq(302)
  end

  it 'creates a milestone with auto drive atach inavalid url 2' do

    s = double()
    allow(s).to receive(:file_by_url).with(anything()) { raise URI::InvalidURIError }

    GoogleDrive.stub(:login_with_oauth).with(anything()) { s }

    session[:user_id] = @ad_user.id

    r = Resource.new
    r.doc_id= '1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0'
    r.title= 'feedback'
    r.url= 'https://docs.google.com/document/d/1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0/edit'
    r.save!

    @t.resource_id=r.id
    @t.save!

    get :generate, :person_id=>@admin.id, :id=>@c.id
    expect(response.status).to eq(302)
  end

end