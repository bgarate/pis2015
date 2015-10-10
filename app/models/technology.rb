# == Schema Information
#
# Table name: technologies
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Technology < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :projects
end
