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
  validates :name, :email, presence: true
  validates :email, format: { with: /\A([-a-z0-9\.]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  has_many :person_milestones
  has_many :milestones, through: :person_milestones
end
