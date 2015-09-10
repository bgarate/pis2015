class PersonSkill < ActiveRecord::Base
  belongs_to :person
  has_one :skill
end
