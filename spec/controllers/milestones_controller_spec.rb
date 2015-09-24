require 'rails_helper'

describe MilestonesController, "Milestone Controller" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  # before do
  #   #Creo milestone
  #   @milestone = Milestone.new :title=>'milestone1',:due_date=>Time.now + (0*0*0*1*60*60),
  #                              :description=>'desc1',:status=> 1, :icon=> 'unIcon',
  #                              :created_at=> Time.now, :updated_at=>Time.now
  #   @milestone.save!
  # end
  before do
    # Creo una persona de tipo administrador
    @admin = Person.new :name=>'NombreAdmin', :email=>'mail@admin.com', :admin=>true
    @admin.save!
    # Creo un usuario asociado a dicha persona
    @ad_user = User.new :person => @admin
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @ad_user.oauth_expires_at = Time.current().advance(days:1)
    @ad_user.save!
    # Creo una persona que NO es administrador
    @no_admin = Person.new :name=>'NombreNoAdmin', :email=>'mail@noadmin.com', :admin=>false
    @no_admin.save!
    # Creo un usuario asociado a dicha persona
    @no_ad_user = User.new :person => @no_admin
    # Seteo la expiracion de la sesion a un dia a partir del momento actual
    @no_ad_user.oauth_expires_at = Time.current().advance(days:1)
    @no_ad_user.save!
  end

  describe 'Get' do

    it 'gets the New page' do
      session[:user_id] = @ad_user.id
      get :new, :session => session
      # Espero que me muestre el formulario
      expect(response).to render_template("new")
    end

  end

  #
  # describe 'Milestone' do
  #   it 'is valid with a title and description' do
  #     session[:user_id] = @ad_user.id
  #     get :create, {:milestone=>{:title=>'Milestone1', :description=>'unadescripciondemilestone'}}
  #     expect(response.status).to eq(302)
  #   end
  #
  #   it 'is invalid without a title' do
  #     session[:user_id] = @ad_user.id
  #     get :create, {:milestone=>{:title=>'', :description=>'unadescripciondemilestone'}}
  #     expect(response.status).to eq(302)
  #   end
  #   it 'is invalid without a description' do
  #     session[:user_id] = @ad_user.id
  #     get :create, {:milestone=>{:title=>'Milestone1', :description=>'unadescripciondemilestone'}}
  #     expect(response.status).to eq(302)
  #   end
  #
  #   it 'is invalid with a due_date before now' do
  #     m1 = Milestone.new
  #     m1.id=4
  #     m1.title ='Milestone for testing'
  #     m1.description='This is a milestone to test Milestones'
  #     m1.due_date=Time.now - 5.days
  #     m1.created_at= Time.now
  #     m1.updated_at= Time.now
  #     m1.status=1
  #     m1.icon= 'Icon'
  #     expect(m1.due_date).to be > Time.now
  #
  #   end
  #
  # end
  #
  #
  #
  #
  # it "Deberia modificar el status a done" do
  #   m1 = Milestone.new
  #   m1.title = 'Entrega del prototipo de alfred'
  #   m1.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
  #   m1.due_date= Time.now - (3*2*7*24*60*60)
  #   m1.status=0
  #   m1.save!
  #
  #   put :update, :id => m1.id, :milestone => { :status => :done }
  #   m1.reload
  #   expect(m1.status).to eq 'done'
  # end

end

