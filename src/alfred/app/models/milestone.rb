class Milestone < ActiveRecord::Base
  has_many :person_milestones
  has_many :people, through: :person_milestones
end
