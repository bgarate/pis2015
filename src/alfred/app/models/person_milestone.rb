class PersonMilestone < ActiveRecord::Base
  belongs_to :person
  belongs_to :milestone
end