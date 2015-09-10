require 'rails_helper'

describe 'Person' do

  before do
    @master = Person.new :name => 'Obiwan'
    @padawan = Person.new :name => 'Look'
    @project = Project.new :name => 'Equilibrar la fuerza'
    @ms = Milestone.new :title => 'Destruir Death Star'
    @techRole = TechRole.new :name => 'Jedi'
    @skill = Skill.new :name => 'Mover piedras con la mente'

    @master.mentees<<(@padawan)
    @master.projects<<(@project)
    @padawan.projects<<(@project)
    @padawan.milestones<<(@ms)
    @master.tech_role = @techRol
    @master.skills<<(@skill)

    @padawan.save!
    @master.save!


  end
  it 'debería tener a Look como discípulo' do
    expect(@master.mentees).to include(@padawan)
  end
  it 'debería tener a Obiwan como maestro' do
    expect(@padawan.mentors).to include(@master)
  end
end