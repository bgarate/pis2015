# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  name         :string
#  email        :string
#  cellphone    :string
#  phone        :string
#  birth_date   :date
#  start_date   :date
#  end_date     :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tech_role_id :integer
#  admin        :boolean
#  image_id     :string
#

class Person < ActiveRecord::Base

  validates :name, :email, :start_date, presence: true
  validates :email, format: { with: /\A([-a-z0-9\.]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  has_one :user
  has_many :person_milestones
  has_many :milestones, through: :person_milestones
  belongs_to :tech_role
  has_many :participations
  has_many :projects, through: :participations


  # mentees_asignations es una collection de <init_date, finish_date, mentee>
  has_many :mentees_assignations, foreign_key: :mentor_id, class_name: "Mentorship"
  # mentees es una collection de <mentee>
  has_many :mentees, through: :mentees_assignations, source: :mentee


  # mentors_asignations es una collection de <init_date, finish_date, mentor>
  has_many :mentor_assignations, foreign_key: :mentee_id, class_name: "Mentorship"
  # mentors es una collection de <mentor>
  has_many :mentors, through: :mentor_assignations, source: :mentor

  # feedbacks
  has_many :authored_feedbacks, foreign_key: :feedback_author_id, class_name: 'Milestone'

  has_many :person_skills
  has_many :skills, through: :person_skills
end


