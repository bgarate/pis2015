class Person < ActiveRecord::Base
  has_many :person_milestones
  has_many :milestones, through: :person_milestones
  has_one :tech_rol
  has_many :participations
  has_many :projects, through: :participations
  has_many :mentorships
  has_many :person_skills
  has_many :skills, through: :person_skills

end

