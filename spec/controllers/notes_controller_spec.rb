require 'rails_helper'

describe NotesController, "Notes Controller" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  before do
    @m1 = Milestone.new
    @m1.title ='Milestone for testing'
    @m1.description='This is a milestone to test Milestones'
    @m1.due_date=Time.now - 5.days
    @m1.created_at= Time.now
    @m1.updated_at= Time.now
    @m1.status=1
    @m1.icon= 'Icon'
    @m1.save!

    @admin = Person.new :name=>'NombreAdmin', :email=>'mail@admin.com', :start_date=>Time.current(), :admin=>true
    @admin.save!

    @ad_user = User.new :person => @admin
    @ad_user.oauth_expires_at = Time.current().advance(days:1)
    @ad_user.save!
  end

describe 'Note' do

  it "creates a note" do
    session[:user_id] = @ad_user.id
    request.env['HTTP_REFERER']= '/milestones'
    post :create, :milestone_id =>@m1.id, :note=>{:text=>'un texto pa la nota', :milestone_id=>@m1.id}
    expect(response.status).to eq(302)
  end

  it "creates another note" do
    session[:user_id] = @ad_user.id
    request.env['HTTP_REFERER']= '/people/1'
    post :create, :milestone_id =>@m1.id, :note=>{:text=>'un texto pa la nota', :milestone_id=>@m1.id}
    expect(response.status).to eq(302)
  end

  it 'destroys a note' do
    n1=@m1.notes.create({:text=> 'una nota pa borrar'})
    session[:user_id] = @ad_user.id
    delete :destroy, :milestone_id =>@m1.id, :id=>n1.id

  end

end

end