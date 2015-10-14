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

tr2 = TechRole.new
tr2.name= "iOS Developer"
tr2.save!

################# Categories #################

e = Category.create(name: "Evento")
e.save!
c = Category.create(name: "Conferencia")
f = Category.create(name: 'Feedback')


################# Milestones #################

m = Milestone.new
m.title = 'Conferencia Tecnológica'
m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas. Ademas de cafe y galletitas maria gratis'
m.due_date= Time.now + (3*2*7*24*60*60)
m.status=0
m.icon = "test/silueta.gif"
m.category = e
m.icon = "glyphicon-flag"

m1 = Milestone.new
m1.title = 'Entrega del prototipo de alfred'
m1.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
m1.due_date= Time.now - (3*2*7*24*60*60)
m1.status=0
m1.category = c
m1.icon = "glyphicon-flag"

m2 = Milestone.new
m2.title = 'Otra entrega de alfred'
m2.description = 'Esperemos meter mas puntos que 10'
m2.due_date = Time.now
m2.status = 0
m2.category = f
m2.save!
m2.icon = "glyphicon-flag"

################# Skills #################

sk1 = Skill.new
sk1.name='angular'
sk1.icon='skills/angular.png'
sk2 = Skill.new
sk2.name='java'
sk2.icon='skills/java.png'


################# Projects #################

pro = Project.new
pro.name= 'Super Tortas 0.1'
pro.client= 'ATU'
pro.status= 0
pro.start_date= Time.now - (2*7*24*60*60)
pro.end_date= Time.now - (2*7*24*60*60)


################# Technologies #################

tech1 = Technology.new
tech1.name = 'Java'
tech1.save!
tech2 = Technology.new
tech2.name = 'Ruby'
tech2.save!
tech3 = Technology.new
tech3.name = 'Android'
tech3.save!


################# Tags #################

Tag.create!(name:'Dar Feedback')
Tag.create!(name:'Recibir Feedback')
Tag.create!(name:'Inicio proyecto')
Tag.create!(name:'Fin proyecto')
Tag.create!(name:'Speacker')
Tag.create!(name:'Participación')


################# People #################

p0 = Person.create!(name: "Alfred", email: "alfred.pis.2015@gmail.com", admin: true,birth_date: 4.years.ago, start_date: 3.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")
p1 = Person.create!(name: "Bruno Garate", email: "bruno.garate@gmail.com", admin: true, start_date: 3.years.ago, image_id: "y5cgoifotmmbkh1l1mn4.jpg")
p2 = Person.create!(name: "Diego Bortot", email: "bortotdiegogm@gmail.com", admin: true, start_date: 23.years.ago , image_id: "lfblntfejcpmmkh0wfny.jpg")
p3 = Person.create!(name: "Oscar Montañés", email: "omontanes@gmail.com", admin: true, start_date: 23.years.ago , image_id: "lfblntfejcpmmkh0wfny.jpg")
p3 = Person.create!(name: "Sebastían Soleri", email: "omontanes.guri@gmail.com", admin: false, start_date: 23.years.ago , image_id: "lfblntfejcpmmkh0wfny.jpg")
p4 = Person.create!(name: "Gonzalo Herrera", email: "gonzalo.herrera.1993@gmail.com", admin: true, start_date: 2.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")
p5 = Person.create!(name: "Maxi", email: "maxikotvi@gmail.com", admin: false, start_date: 23.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")
p6 = Person.create!(name: "Andy", email: "andresvasilev@gmail.com", admin: false, start_date: 2.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")
p7 = Person.create!(name: "Rodrigo", email: "rodrigoberon2014@gmail.com", admin: false, start_date: 2.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")
Person.create!(name: "Martin Cabrera", email: "martin.cabrera@moove-it.com", admin: true, start_date: '2007-01-15', birth_date: '1980-04-16', cellphone: '099143405', phone: '27066071', image_id: "lfblntfejcpmmkh0wfny.jpg")
Person.create!(name: "Andreas Fast", email: "andreas.fast@moove-it.com", admin: false, start_date: '2014-08-15', birth_date: '1990-04-16', cellphone: '099143406', phone: '27066071', image_id: "lfblntfejcpmmkh0wfny.jpg")
Person.create!(name: "Miguel Renom", email: "miguel.renom@moove-it.com", admin: false, start_date: '2014-08-15', birth_date: '1990-04-16', cellphone: '099143406', phone: '27066071', image_id: "lfblntfejcpmmkh0wfny.jpg")


p0.projects << pro
p0.skills << sk1
p0.skills << sk2
p0.tech_role = tr
p0.milestones << m
p0.milestones << m1


p1.projects << pro
p1.skills << sk1
p1.skills << sk2
p1.tech_role = tr2


p4.projects << pro
p4.skills << sk1
p4.skills << sk2
p4.tech_role = tr2
p4.milestones << m
p4.milestones << m1
p4.milestones << m2


p5.projects << pro
p5.skills << sk1
p5.skills << sk2
p5.tech_role = tr2
p5.milestones << m
p5.milestones << m1
p5.milestones << m2


p6.projects << pro
p6.skills << sk1
p6.skills << sk2
p6.tech_role = tr2
p6.mentees << p4
p6.mentees << p5
p6.milestones << m
p6.milestones << m1
p6.milestones << m2



