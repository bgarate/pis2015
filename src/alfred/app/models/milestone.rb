class Milestone < ActiveRecord::Base
  has_many :person_milestones
  has_many :people, through: :person_milestones
  has_many :notes
  has_many :resources
  has_one :category
end

