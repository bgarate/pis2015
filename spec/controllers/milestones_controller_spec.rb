require 'rails_helper'

describe MilestonesController, "Controller de hitos" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
  end

  before do
    @m1 = Milestone.new
    @m1.title = 'Entrega del prototipo de alfred'
    @m1.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
    @m1.due_date= Time.now - (3*2*7*24*60*60)
    @m1.milestone_type = :feedback
    @m1.status=0
    @m1.save!

    @m2 = Milestone.new
    @m2.title = 'Entrega del prototipo de alfred'
    @m2.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
    @m2.due_date= Time.now - (3*2*7*24*60*60)
    @m2.milestone_type = :event
    @m2.status=0
    @m2.save!

    @person = Person.new :name=>'NombreNoAdmin', :email=>'mail@noadmin.com', :start_date=>Time.current(), :admin=>false
    @person.save!
  end

  it "Deveria modificar el status a done" do
    put :update, :id => @m1.id, :milestone => { :status => :done, :feedback_author => NIL}
    @m1.reload
    expect(@m1.status).to eq "done"
  end

  it "añade un revisor a un hito de tipo feedback" do
    put :update, :id => @m1.id, :milestone => {:feedback_author =>  @person }
    @m1.reload
    expect(@m1.feedback_author).to eq @person
  end

  it "no añade un revisor a un hito que no es tipo feedback" do
    put :update, :id => @m2.id, :milestone => {:feedback_author =>  @person }
    @m2.reload
    expect(@m2.feedback_author).to eq NIL
  end

end

