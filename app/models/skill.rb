# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  name       :string
#  type       :integer
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Skill < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :person_skill
end
