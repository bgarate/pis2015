class Person < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, format: { with: /\A([-a-z0-9\.]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  has_many :person_milestones
  has_many :milestones, through: :person_milestones
end
