require 'rails_helper'

describe MilestonesController, "Controller de hitos" do
  before do
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

  it "Deveria modificar el status a done" do
    m1 = Milestone.new
    m1.title = 'Entrega del prototipo de alfred'
    m1.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
    m1.due_date= Time.now - (3*2*7*24*60*60)
    m1.status=0
    m1.save!

    put :update, :id => m1.id, :milestone => { :status => :done }
    m1.reload
    expect(m1.status).to eq "done"
  end

  describe "permisos" do
    it 'Deveria renderizar show por ser admin' do

      session[:user_id] = @ad_user.id
      get :show, :id => @m.id
      expect(response.status).to eq(200)
    end

    it 'Deveria renderizar  show por ser mentor' do
      @no_ad_user.person.mentees<<(@ad_user.person)
      @no_ad_user.save!
      @ad_user.person.milestones<<(@m)
      @ad_user.save!

      session[:user_id] = @no_ad_user.id
      get :show, :id => @m.id
      expect(response.status).to eq(200)
    end

    it 'Deveria redireccionar a root path por no ser admin ni mentor' do

      session[:user_id] = @no_ad_user.id
      get :show, :id => @m.id
      expect(response).to redirect_to root_path
    end
  end

end

