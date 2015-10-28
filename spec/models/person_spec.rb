# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  name         :string
#  email        :string
#  cellphone    :string
#  phone        :string
#  birth_date   :date
#  start_date   :date
#  end_date     :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tech_role_id :integer
#  admin        :boolean
#  image_id     :string
#

require 'rails_helper'

describe 'Person' do

  before do
    @master = Person.new :name => 'Obiwan', :email => 'obi@jedi.com', :start_date=>Time.current()
    @padawan = Person.new :name => 'Luke', :email => 'luke@jedi.com', :start_date=>Time.current()
    @project = Project.new :name => 'Equilibrar la fuerza', :client => 'Rebeldes', :status=>"active"
    @ms = Milestone.new :title => 'Destruir Death Star', :description=>'De nuevo'
    @techRole = TechRole.new :name => 'Jedi'
    @skill = Skill.new :name => 'Mover piedras con la mente'
    @skill2 = Skill.new :name => 'uso del sable'
    @nota = Note.new :text => 'Usar la fuerza', :author => @padawan, :visibility => 'me'
    @technology = Technology.new :name => 'X Wings'
    @technology2 = Technology.new :name => 'Falcon millenium'
    @admin = Person.new :name=>'NombreAdmin', :email=>'mail@admin.com', :start_date=>Time.current(), :admin=>true


    @ms.notes<<(@nota)
    @master.mentees<<(@padawan)
    @master.projects<<(@project)
    @padawan.projects<<(@project)
    @project.technologies<<(@technology)
    @project.technologies<<(@technology2)
    @padawan.milestones<<(@ms)
    @master.skills<<(@skill)
    @master.skills<<(@skill2)
    @master.tech_role=@techRole
    @padawan.tech_role=@techRole





    @padawan.save!
    @master.save!
    @admin.save!


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
  it 'el master y padawan son jedi' do
    expect(@master.tech_role).to eq(@techRole)
    expect(@padawan.tech_role).to eq(@techRole)
  end
  it 'el master tiene skilles' do
    expect(@master.skills).to include(@skill)
    expect(@master.skills).to include(@skill2)
  end
  it 'el milestone tiene a padawan asociado' do
    expect(@ms.people).to include(@padawan)
  end
  it 'el milestone no tiene a master asociado' do
    expect(@ms.people).not_to include(@master)
  end

  it 'el milestone tiene nota asociada hecha por padawan' do
    expect(@ms.notes).to include(@nota)
    expect(@nota.author).to eq(@padawan)
  end

  it 'el proyecto tiene 2 technoloies' do
    expect(@project.technologies).to include(@technology)
    expect(@project.technologies).to include(@technology2)
  end

  it 'existe un usuario administrador' do
    expect(@admin).to be_valid
    expect(@admin.admin).to eq(true)
    @aux = Person.find @admin.id
    expect(@aux.admin).to eq(true)
  end

  it 'si es administrador, el siguiente valor es no_admin' do
    expect(@admin.get_next_admin_value).to eq(:no_admin)
  end

  it 'si es no administrador, el siguiente valor es admin' do
    expect(@master.get_next_admin_value).to eq(:admin)
  end

end
