require 'rails_helper'
require 'spec_helper'

describe 'ProjectHelper' do
  it 'Carga tecnologias' do
    @p = Project.new :name => 'Equilibrar la fuerza', :client => 'Rebeldes', :status=>"active"
    helper.selected_technologies(@p)
  end

  it 'project_status_glyphicon' do
    @p = Project.new :name => 'Equilibrar la fuerza', :client => 'Rebeldes', :status=>"active"
    helper.project_status_glyphicon(@p)
  end
end