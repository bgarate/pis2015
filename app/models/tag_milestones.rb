# == Schema Information
#
# Table name: person_milestones
#
#  id              :integer          not null, primary key
#  person_id       :integer
#  milestone_id    :integer
#  completion_date :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class PersonMilestone < ActiveRecord::Base
  belongs_to :person
  belongs_to :milestone
end
