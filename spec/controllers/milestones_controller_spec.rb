require 'rails_helper'

describe MilestonesController, "Milestone Controller" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end


  describe 'Milestone' do

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "creates a milestone" do
      post :new
      post :create, {:milestone=>{:title=>'milestone1', :description=>'unadescripcionde1'}}
      expect(response.status).to eq(302)

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


    it 'mostrar la milestone' do
        m1 = Milestone.new
        m1.title ='Milestone for testing'
        m1.description='This is a milestone to test Milestones'
        m1.due_date=Time.now - 5.days
        m1.created_at= Time.now
        m1.updated_at= Time.now
        m1.status=1
        m1.icon= 'Icon'
        m1.save!
        get :show, :id => m1.id

        expect(response).to render_template("show")
      end




    end









  #
  #
  #   it 'is valid with a title and description' do
  #     session[:user_id] = @ad_user.id
  #     get :create, {:milestone=>{:title=>'Milestone1', :description=>'unadescripciondemilestone', :due_date=>Time.now}}
  #     expect(response.status).to eq(302)
  #   end
  #
  #   it 'is invalid without a title' do
  #     session[:user_id] = @ad_user.id
  #     get :create, {:milestone=>{ :description=>'unadescripciondemilestone'}}
  #     expect(response).to redirect_to("new")
  #   end
  #   it 'is invalid without a description' do
  #     session[:user_id] = @ad_user.id
  #     get :create, {:milestone=>{:title=>'Milestone1'}}
  #     expect(response.status).to eq(302)
  #   end
  #
  #   it 'is invalid with a due_date before now' do
  #     m1 = Milestone.new
  #
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


  it "Deberia modificar el status a done" do
    m2 = Milestone.new
    m2.title = 'Entrega del prototipo de alfred'
    m2.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
    m2.due_date= Time.now - (3*2*7*24*60*60)
    m2.status=0
    m2.save!

    get :set_as_done, :milestone_id => m2.id
    m2.reload
    expect(m2.status).to eq 'done'
  end



end

