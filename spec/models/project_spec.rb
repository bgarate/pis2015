require 'rails_helper'

describe 'Project' do

  before do
    @project = Project.new :name => 'Equilibrar la fuerza', :client => 'Rebeldes', :status=>"active"

  end

  it 'debería tener a Look como discípulo' do
    expect(Project.status_names_for_select).to eq([["Activo", "active"], ["Inactivo", "inactive"], ["Finalizado", "finished"]])
  end

  it 'deberia imprimir el estado' do
    expect(@project.display_status).to eq('Activo')
  end


end