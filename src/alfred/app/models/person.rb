class Person < ActiveRecord::Base
=begin
  has_one :name
  has_one :mail1
  has_one :mail2
  has_one :tel1
  has_one :tel2
  has_one :birthDate
  has_one :initDate
  has_one :sex
  has_one :finishDate
  has_many :techRol
=end
  has_many :person_milestones
  has_many :milestones, through: :person_milestones
end
