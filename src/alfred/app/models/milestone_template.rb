class MilestoneTemplate < ActiveRecord::Base

  has_many :resources
  belongs_to :category
end
