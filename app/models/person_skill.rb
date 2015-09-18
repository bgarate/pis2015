# == Schema Information
#
# Table name: person_skills
#
#  id         :integer          not null, primary key
#  since_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :integer
#  skill_id   :integer
#

class PersonSkill < ActiveRecord::Base
  belongs_to :person
  belongs_to :skill
end
