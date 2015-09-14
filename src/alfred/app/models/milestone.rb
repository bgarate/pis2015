class Milestone < ActiveRecord::Base
  has_many :person_milestones
  has_many :people, through: :person_milestones
  has_many :notes
  has_many :resources
  belongs_to :category
end

