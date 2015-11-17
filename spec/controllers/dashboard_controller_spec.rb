require 'rails_helper'

describe DashboardController, "Dashboard Controller" do

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

  end


  before do

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

    # Creo una persona que NO es administrador ni mentor
    @no_admin_no_mentor = Person.new :name=>'NombreNoAdminNiMentor', :email=>'mail2@noadminnimentor.com', :start_date=>Time.current(), :admin=>false
    @no_admin_no_mentor.save!
    # Creo un usuario asociado a dicha persona
    @no_mentor = User.new :person => @no_admin_no_mentor
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @no_mentor.oauth_expires_at = Time.current().advance(days:1)
    @no_mentor.save!

  end

  describe "permisos" do

    it 'Deberia renderizar index por ser mentor' do
      @no_ad_user.person.mentees<<(@ad_user.person)
      @no_ad_user.save!

      session[:user_id] = @no_ad_user.id
      get :index, :id => @no_ad_user.id
      expect(response.status).to eq(200)
    end

    it 'post index' do

      m = Milestone.new
      m.title = 'Conferencia Tecnológica'
      m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas. Ademas de cafe y galletitas maria gratis'
      m.due_date= Time.now + (3*2*7*24*60*60)
      m.status=:pending
      m.icon = "test/silueta.gif"
      m.author= @ad_user.person
      m.category
      m.people<<@no_ad_user.person
      m.save!

      request.env["HTTP_ACCEPT"] = 'application/json'

      session[:user_id] = @ad_user.id
      xhr :post,:index, :id => @ad_user.id, :people => "#{@no_ad_user.id}", :length => 1, :start => 1
      expect(response.status).to eq(200)
    end

  end


end
