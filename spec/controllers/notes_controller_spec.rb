require 'rails_helper'

describe NotesController, "Notes Controller" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

describe 'Note' do

  it "creates a note" do
    m1 = Milestone.new
    m1.title ='Milestone for testing'
    m1.description='This is a milestone to test Milestones'
    m1.due_date=Time.now - 5.days
    m1.created_at= Time.now
    m1.updated_at= Time.now
    m1.status=1
    m1.icon= 'Icon'
    m1.save!


    post :create, :milestone_id =>m1.id, :note=>{:text=>'un texto pa la nota', :milestone_id=>m1.id}
    expect(response.status).to eq(302)
  end

  it 'destroys a note' do
    m1 = Milestone.new
    m1.title ='Milestone for testing'
    m1.description='This is a milestone to test Milestones'
    m1.due_date=Time.now - 5.days
    m1.created_at= Time.now
    m1.updated_at= Time.now
    m1.status=1
    m1.icon= 'Icon'
    m1.save!
    n1=m1.notes.create({:text=> 'una nota pa borrar'})

    delete :destroy, :milestone_id =>m1.id, :id=>n1.id


  end
end




end