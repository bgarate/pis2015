# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


tr = TechRole.new
tr.name= "Desarrollador ruby"
tr.save!

tr2 = TechRole.new
tr2.name= "iOS Developer"
tr2.save!

################# Categories #################
#No usar este create, para obtener esta categoria emplear Category.get_or_create_history_category
#e = Category.create(name: Category::HIST0RY_NAME)
#e.save!
c = Category.create(name: 'Conferencia')
c.is_feedback= false
c.status = 0
c.icon = "glyphicon-align-center"
c.save!

f = Category.create(name: 'Feedback')
f.is_feedback= true
f.status = 0
f.icon = "glyphicon-align-center"
f.save!

f2 = Category.create(name: 'Feedback diseño')
f2.is_feedback= true
f2.status = 0
f2.icon = "glyphicon-arrow-down"
f2.save!

indu = Category.create(name: 'Inducción')
indu.is_feedback= false
indu.status= 0
indu.icon = "glyphicon-arrow-up"
indu.save!

################# Milestones #################

m = Milestone.new
m.title = 'Conferencia Tecnológica'
m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas.'
m.due_date= Time.now + (3*2*7*24*60*60)
m.status=0
m.icon = "test/silueta.gif"
m.category = c
m.icon = "glyphicon-flag"

m1 = Milestone.new
m1.title = 'Entrega del prototipo de alfred'
m1.description= 'Entrega del primer protipo de alfred a moove-it y validación del mismo'
m1.due_date= Time.now - (3*2*7*24*60*60)
m1.status=0
m1.category = c
m1.icon = "glyphicon-flag"

m2 = Milestone.new
m2.title = 'Entrega de alfred'
m2.description = 'Entrega final de alfred y puesta en producción'
m2.due_date = Time.now
m2.status = 0
m2.category = f
m2.save!
m2.icon = "glyphicon-flag"

################# Skills #################

sk1 = Skill.new
sk1.name='angular'
sk1.icon='ekzpgmusbt8ltizifr37.png'
sk2 = Skill.new
sk2.name='java'
sk2.icon='paexsc5nfywcry06fig2.png'


################# Projects #################

pro = Project.new
pro.name= 'Super robots 0.1'
pro.client= 'ATU'
pro.status= 0
pro.start_date= Time.now - (2*7*24*60*60)
pro.end_date= Time.now - (2*7*24*60*60)

pro2 = Project.new
pro2.name= 'Gestión inteligente'
pro2.client= 'BSE'
pro2.status= 0
pro2.start_date= Time.now - (2*7*24*60*60)
pro2.end_date= Time.now + (2*7*24*60*60)

pro3 = Project.new
pro3.name= 'Super Games 1.0'
pro3.client= 'Game World'
pro3.status= 0
pro3.start_date= Time.now - (2*7*24*60*60)
pro3.end_date= Time.now + (2*7*24*60*60)


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
Tag.create!(name:'Speaker')
Tag.create!(name:'Participación')
tagt = Tag.new
tagt.name= 'Destacado'


################# People #################
tr_id = tr2.id

p0 = Person.create!(name: "Alfred", email: "alfred.pis.2015@gmail.com", admin: true,birth_date: 4.years.ago, start_date: 3.years.ago, tech_role_id: tr_id)
p1 = Person.create!(name: "Bruno Garate", email: "bruno.garate@gmail.com", admin: true, start_date: 3.years.ago, image_id: "y5cgoifotmmbkh1l1mn4.jpg", tech_role_id: tr_id)
p1b = Person.create!(name: "Santiago Diaz", email: "sydz92@gmail.com", admin: false, start_date: 1168.years.ago, tech_role_id: tr_id)
p2 = Person.create!(name: "Diego Bortot", email: "bortotdiegogm@gmail.com", admin: true, start_date: 23.years.ago , tech_role_id: tr_id)
p3 = Person.create!(name: "Oscar Montañés", email: "omontanes@gmail.com", admin: true, start_date: 23.years.ago , tech_role_id: tr_id)
p3 = Person.create!(name: "Sebastían Soleri", email: "omontanes.guri@gmail.com", admin: false, start_date: 23.years.ago , tech_role_id: tr_id)
p4 = Person.create!(name: "Gonzalo Herrera", email: "gonzalo.herrera.1993@gmail.com", admin: true, start_date: 2.years.ago, tech_role_id: tr_id)
p5 = Person.create!(name: "Maxi", email: "maxikotvi@gmail.com", admin: false, start_date: 23.years.ago, tech_role_id: tr_id)
p6 = Person.create!(name: "Andy", email: "andresvasilev@gmail.com", admin: true, start_date: 2.years.ago, tech_role_id: tr_id)
p7 = Person.create!(name: "Rodrigo", email: "rodrigoberon2014@gmail.com", admin: false, start_date: 2.years.ago, tech_role_id: tr_id)
Person.create!(name: "Martin Cabrera", email: "martin.cabrera@moove-it.com", admin: true, start_date: '2007-01-15', birth_date: '1980-04-16', cellphone: '099143405', phone: '27066071', tech_role_id: tr_id)
Person.create!(name: "Andreas Fast", email: "andreas.fast@moove-it.com", admin: true, start_date: '2014-08-15', birth_date: '1990-04-16', cellphone: '099143406', phone: '27066071', tech_role_id: tr_id)
Person.create!(name: "Miguel Renom", email: "miguel.renom@moove-it.com", admin: false, start_date: '2014-08-15', birth_date: '1990-04-16', cellphone: '099143406', phone: '27066071', tech_role_id: tr_id)
Person.create!(name: "Cecilia Marcora", email: "cecilia.marcora@moove-it.com", admin: true, start_date: '2014-08-15', birth_date: '1990-04-16', cellphone: '099143406', phone: '27066071', tech_role_id: tr_id)

p0.projects << pro
p0.projects << pro2
p0.projects << pro3
p0.skills << sk1
p0.skills << sk2
p0.tech_role = tr
p0.milestones << m
p0.milestones << m1
p0.save!
m.author_id = p0.id
m.save!
m1.author_id = p0.id
m1.save!
m2.author_id = p0.id
m2.save!


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


p6.skills << sk1
p6.skills << sk2
p6.tech_role = tr2
p6.mentees << p4
p6.mentees << p5
p6.milestones << m
p6.milestones << m1
p6.milestones << m2
p6.projects << pro
p6.projects << pro2
p6.projects << pro3


################# Templates #################
t = Template.new
t.title= 'Inducción ruby'
t.description= 'Periodo en el cual son adquiridos los conocimientos subyacentes que implican el confort en el manejo de ruby como lenguaje de programación'
t.icon= 'glyphicon-flag'
t.category_id=indu.id
t.tags<<(tagt)
t.save!

t1 = Template.new
t1.title= 'Feedback'
t1.description= 'Instancia en la cual un compañero le da una devolución a otro, con el fin de buscar la mejora continua'
t1.icon= 'glyphicon-flag'
t1.category_id=f.id
r = Resource.new
r.doc_id= '1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0'
r.title= 'feedback'
r.url= 'https://docs.google.com/document/d/1bpQ3HB__V1YbQ4YH6CBeDjcKp-YGjH5_WtsxFdNuMk0/edit'
r.save!
t1.resource_id=r.id
t1.save!

t2 = Template.new
t2.title= 'Feedback de diseño'
t2.description= 'Feedback especial para diseñadores'
t2.icon= 'glyphicon-flag'
t2.category_id=f2.id
r1 = Resource.new
r1.doc_id= '1VuyDDm-iDK6LF2uG9Sx8WhTJe2kON-bVW7As3BmIIhI'
r1.title= 'feedback tecnico'
r1.url= 'https://docs.google.com/document/d/1VuyDDm-iDK6LF2uG9Sx8WhTJe2kON-bVW7As3BmIIhI/edit'
r1.save!
t2.resource_id=r1.id
t2.save!

################# Collections #################

cole = Collection.new
cole.title= 'Primeros hitos'
cole.description= 'Hitos que son asignados a una persona cuando esta comienza a trabajar en moove-it'
cole.collection_templates<<CollectionTemplate.new(:template=>t, :days=>2)
cole.collection_templates<<CollectionTemplate.new(:template=>t1, :days=>30)
cole.save!
