require 'rails_helper'

describe MilestonesController, "Controller de hitos" do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:loged?) { '' }
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

end

