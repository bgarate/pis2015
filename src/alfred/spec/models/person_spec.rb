require 'rails_helper'

describe 'Person' do

  before do
    @master = Person.new :name => 'Obiwan'
    @padawan = Person.new :name => 'Luke'
    @project = Project.new :name => 'Equilibrar la fuerza'
    @ms = Milestone.new :title => 'Destruir Death Star'
    @techRole = TechRole.new :name => 'Jedi'
    @skill = Skill.new :name => 'Mover piedras con la mente'
    @skill2 = Skill.new :name => 'uso del sable'

    @master.mentees<<(@padawan)
    @master.projects<<(@project)
    @padawan.projects<<(@project)
    @padawan.milestones<<(@ms)
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
  it 'debería tener a Equilbrar la fuerza como pryecto' do
    expect(@padawan.projects).to include(@project)
  end
  it 'Look deberia ser parte de equilibrar la fuerza' do
    expect(@project.people).to include(@padawan)
  end
  it 'el master también debería tener a Equilbrar la fuerza como pryecto' do
    expect(@master.projects).to include(@project)
  end
  it 'el master es un jedi' do
    expect(@master.tech_role).equal?(@techRol)
  end
  it 'el master es un jedi' do
    expect(@master.skills).to include(@skill)
  end



end