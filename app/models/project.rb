# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  start_date :date
#  end_date   :date
#  client     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  has_and_belongs_to_many :technologies
  has_many :participations
  has_many :people, through: :participations

  enum status:[:active, :inactive, :finished]
end
