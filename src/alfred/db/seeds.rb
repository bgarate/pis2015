# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tr = TechRole.new
tr.name= "Vendedor de Tortas Fritas"
tr.save!

per = Person.new
per.name = 'Alfred'
per.email = 'alfred.pis.2015@gmail.com'
per.birth_date= Time.new(2012, 8, 29, 22, 35, 0)
per.start_date= Time.new(2012, 8, 29, 22, 35, 0)
per.tech_role = tr

m = Milestone.new
m.title = 'Conferencia Tecnológica'
m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas. Ademas de cafe y galletitas maria gratis'
m.due_date= Time.now + (3*2*7*24*60*60)
m.milestone_type= 1
m.status=0
per.milestones<<(m)

m1 = Milestone.new
m1.title = 'Entrega del prototipo de alfred'
m1.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
m1.due_date= Time.now - (3*2*7*24*60*60)
m1.status=0
per.milestones<<(m1)

sk1 = Skill.new
sk1.name='angular'
sk1.icon='skills/angular.png'
sk2 = Skill.new
sk2.name='java'
sk2.icon='skills/java.png'
per.skills<<(sk1)
per.skills<<(sk2)

pro = Project.new
pro.name= 'Super Tortas 0.1'
pro.start_date= Time.now - (2*7*24*60*60)
pro.end_date= Time.now - (2*7*24*60*60)
per.projects<<(pro)

per.save!

p1 = Person.create!(name: "Bruno Garate", email: "bruno.garate@gmail.com", admin: true, start_date: 3.years.ago)

p1.milestones.create(title: "Un hito de prueba",
  description: "Esta es la descripción del hito",
  due_date: Time.now + 5*24*60*60)

p1.milestones.create(title: "Otro hito de prueba",
                     description: "Una descripción un poquito mas larga que no entra en una sola linea",
                     due_date: Time.now - 5*24*60*60)