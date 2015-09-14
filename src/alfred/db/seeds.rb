# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p1 = Person.create!(name: "Bruno Garate", email: "bruno.garate@gmail.com", admin: true, start_date: 3.years.ago)
p1.user = User.create!()

p1.milestones.create(title: "Un hito de prueba",
  description: "Esta es la descripción del hito",
  due_date: Time.now + 5*24*60*60)

p1.milestones.create(title: "Otro hito de prueba",
                     description: "Una descripción un poquito mas larga que no entra en una sola linea",
                     due_date: Time.now - 5*24*60*60)