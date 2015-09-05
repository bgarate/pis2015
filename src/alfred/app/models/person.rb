class Person < ActiveRecord::Base
  has_many :person_milestones
  has_many :milestones, through: :person_milestones
end
