class Person < ActiveRecord::Base
  has_many :person_milestones
  has_many :milestones, through: :person_milestones
  has_one :tech_rol
  has_many :participations
  has_many :projects, through: :participations


  # mentees_asignations es una collection de <init_date, finish_date, mentee>
  has_many :mentees_assignations, foreign_key: :mentor_id, class_name: "Mentorship"
  # mentees es una collection de <mentee>
  has_many :mentees, through: :mentees_assignations, source: :mentee


  # mentors_asignations es una collection de <init_date, finish_date, mentor>
  has_many :mentor_assignations, foreign_key: :mentee_id, class_name: "Mentorship"
  # mentors es una collection de <mentor>
  has_many :mentors, through: :mentor_assignations, source: :mentor



  has_many :person_skills
  has_many :skills, through: :person_skills

  has_one :user
  has_many :person_milestones
  has_many :milestones, through: :person_milestones
end


