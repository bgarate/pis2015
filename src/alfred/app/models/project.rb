class Project < ActiveRecord::Base
  has_and_belongs_to_many :technologies
  has_many :participations
  has_many :people, through: :participations
end
