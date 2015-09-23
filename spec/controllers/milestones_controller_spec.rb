require 'rails_helper'

describe MilestonesController, "Controller de hitos" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  before do
    #Creo milestone
    @milestone = Milestone.new :title=>'milestone1',:due_date=>Time.now + (0*0*0*1*60*60),
                               :description=>'desc1',:status=> 1, :icon=> 'unIcon',
                               :created_at=> Time.now, :updated_at=>Time.now
    @milestone.save!
  end

  describe 'Milestone' do
    it 'is valid with a title and description' do
      m1 = Milestone.new
      m1.id=1
      m1.title ='Milestone for testing'
      m1.description='This is a milestone to test Milestones'
      m1.due_date=Time.now + 10.days
      m1.created_at= Time.now
      m1.updated_at= Time.now
      m1.status=1
      m1.icon= 'Icon'
      expect(m1).to be_valid
    end

    it 'is invalid without a title' do
      m1 = Milestone.new
      m1.id=2
      m1.title =''
      m1.description='This is a milestone to test Milestones'
      m1.due_date=Time.now + 10.days
      m1.created_at= Time.now
      m1.updated_at= Time.now
      m1.status=1
      m1.icon= 'Icon'
      expect(m1).not_to be_valid
    end
    it 'is invalid without a description' do
      m1 = Milestone.new
      m1.id=3
      m1.title ='Milestone for testing'
      m1.description=''
      m1.due_date=Time.now + 10.days
      m1.created_at= Time.now
      m1.updated_at= Time.now
      m1.status=1
      m1.icon= 'Icon'
      expect(m1).not_to be_valid
    end

    it 'is invalid with a due_date before now' do
      m1 = Milestone.new
      m1.id=4
      m1.title ='Milestone for testing'
      m1.description='This is a milestone to test Milestones'
      m1.due_date=Time.now - 5.days
      m1.created_at= Time.now
      m1.updated_at= Time.now
      m1.status=1
      m1.icon= 'Icon'
      expect(m1.due_date).to be > Time.now

    end

  end




  it "Deberia modificar el status a done" do
    m1 = Milestone.new
    m1.title = 'Entrega del prototipo de alfred'
    m1.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
    m1.due_date= Time.now - (3*2*7*24*60*60)
    m1.status=0
    m1.save!

    put :update, :id => m1.id, :milestone => { :status => :done }
    m1.reload
    expect(m1.status).to eq 'done'
  end

end

