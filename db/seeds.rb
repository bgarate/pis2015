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

c = Category.create(name: "Conferencia")
f = Category.create(name: 'Feedback')

per = Person.new
per.name = 'Alfred'
per.email = 'alfred.pis.2015@gmail.com'
per.birth_date= Time.new(2012, 8, 29, 22, 35, 0)
per.start_date= Time.new(2012, 8, 29, 22, 35, 0)
per.tech_role = tr
per.image_id = "lfblntfejcpmmkh0wfny.jpg"
per.admin=true

m = Milestone.new
m.title = 'Conferencia Tecnológica'
m.description= 'Se va a hablar de como las aspiradors roboticas van a cambiar nuestras vidas. Ademas de cafe y galletitas maria gratis'
m.due_date= Time.now + (3*2*7*24*60*60)
m.status=0
m.icon = "test/silueta.gif"
m.category = c
per.milestones<<(m)

m1 = Milestone.new
m1.title = 'Entrega del prototipo de alfred'
m1.description= 'Hay que entregar el protipo de alfred a la gente de pis. Ademas de cafe y galletitas maria gratis'
m1.due_date= Time.now - (3*2*7*24*60*60)
m1.status=0
m1.category = c
per.milestones<<(m1)

m2 = Milestone.new
m2.title = 'Otra entrega de alfred'
m2.description = 'Esperemos meter mas puntos que 10'
m2.due_date = Time.now
m2.status = 0
m2.category = f
m2.save!

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
pro.client= 'ATU'
pro.status= 0
pro.start_date= Time.now - (2*7*24*60*60)
pro.end_date= Time.now - (2*7*24*60*60)
per.projects<<(pro)

per.save!

p1 = Person.create!(name: "Bruno Garate", email: "bruno.garate@gmail.com", admin: true, start_date: 3.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")

p1.milestones.create(title: "Un hito de prueba",
  description: "Esta es la descripción del hito",
  due_date: Time.now + 5*24*60*60)

p1.milestones.create(title: "Otro hito de prueba",
                     description: "Una descripción un poquito mas larga que no entra en una sola linea",
                     due_date: Time.now - 5*24*60*60)

p1.projects << pro
p1.skills << sk1
p1.skills << sk2
p1.tech_role = tr2

p2 = Person.create!(name: "Diego Bortot", email: "bortotdiegogm@gmail.com", admin: true, start_date: 23.years.ago , image_id: "lfblntfejcpmmkh0wfny.jpg")
p3 = Person.create!(name: "Oscar Montañés", email: "omontanes@gmail.com", admin: true, start_date: 23.years.ago , image_id: "lfblntfejcpmmkh0wfny.jpg")
p3 = Person.create!(name: "Sebastían Soleri", email: "omontanes.guri@gmail.com", admin: false, start_date: 23.years.ago , image_id: "lfblntfejcpmmkh0wfny.jpg")
p4 = Person.create!(name: "Gonzalo Herrera", email: "gonzalo.herrera.1993@gmail.com", admin: true, start_date: 2.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")
p5 = Person.create!(name: "Maxi", email: "maxikotvi@gmail.com", admin: false, start_date: 23.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")

tech1 = Technology.new
tech1.name = 'Java'
tech1.save!
tech2 = Technology.new
tech2.name = 'Ruby'
tech2.save!
tech3 = Technology.new
tech3.name = 'Android'
tech3.save!


Tag.create!(name:'Dar Feedback')
Tag.create!(name:'Recibir Feedback')
Tag.create!(name:'Inicio proyecto')
Tag.create!(name:'Fin proyecto')
Tag.create!(name:'Speacker')
Tag.create!(name:'Participación')


# Datos de Prueba para Bill Hicks
p6 = Person.create!(name: "Andy", email: "andresvasilev@gmail.com", admin: false, start_date: 2.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")

p6.milestones.create(title: "Aprendio a programar",
                     description: "Esta es la descripción del hito",
                     due_date: Time.now + 5*24*60*60)

p6.milestones.create(title: "Otro hito de prueba",
                     description: "Una descripción un poquito mas larga que no entra en una sola linea",
                     due_date: Time.now - 5*24*60*60)

p6.projects << pro
p6.skills << sk1
p6.skills << sk2
p6.tech_role = tr2


# Datos de Prueba para John Doe
p7 = Person.create!(name: "John Doe", email: "johndoe@gmail.com", admin: false, start_date: 1.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")

p7.milestones.create(title: "Hito 1",
                     description: "Esta es la descripción del hito",
                     due_date: Time.now + 5*24*60*60,status: :done)

p7.milestones.create(title: "Hito 2",
                     description: "Una descripción un poquito mas larga que no entra en una sola linea",
                     due_date: Time.now - 5*24*60*60,status: :pending)

p7.milestones.create(title: "Hito 3",
                     description: "Esta es la descripción del hito",
                     due_date: Time.now + 5*24*60*60,status: :rejected)


p7.projects << pro
p7.skills << sk1
p7.skills << sk2
p7.tech_role = tr2

# Datos de Prueba para John Doe
p8 = Person.create!(name: "Bill Cooper", email: "billcooper@gmail.com", admin: false, start_date: 1.years.ago, image_id: "lfblntfejcpmmkh0wfny.jpg")

p8.milestones.create(title: "Hito 1",
                     description: "Hito 1",
                     due_date: Time.now + 5*24*60*60,status: :done)

p8.milestones.create(title: "Hito 2",
                     description: "Una descripción un poquito mas larga que no entra en una sola linea",
                     due_date: Time.now - 5*24*60*60,status: :done)

p8.milestones.create(title: "Hito 3",
                     description: "Esta es la descripción del hito",
                     due_date: Time.now + 5*24*60*60,status: :done)


p8.projects << pro
p8.skills << sk1
p8.skills << sk2
p8.tech_role = tr2

p6.mentees<<p7
p6.mentees<<p8