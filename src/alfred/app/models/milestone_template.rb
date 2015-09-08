class MilestoneTemplate < ActiveRecord::Base
  has_many :person_milestones
  has_many :resources
  has_one :category
end
