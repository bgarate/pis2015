# == Schema Information
#
# Table name: milestones
#
#  id             :integer          not null, primary key
#  title          :string
#  due_date       :date
#  description    :text
#  status         :integer
#  milestone_type :integer
#  icon           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :integer
#

class Milestone < ActiveRecord::Base
  has_many :person_milestones
  has_many :people, through: :person_milestones
  has_many :notes
  has_many :resources
  belongs_to :category
  enum status: [:pending, :done, :rejected]
  enum milestone_type: [ :feedback, :event ]

  # autor del feedback
  belongs_to :feedback_author, class_name: 'Person'

  def get_next_status
    status_order = [:pending, :done, :rejected]

    status_order[(status_order.find_index(self.status.to_sym) + 1) % status_order.count]

  end
end

