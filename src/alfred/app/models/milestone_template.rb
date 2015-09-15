# == Schema Information
#
# Table name: milestone_templates
#
#  id          :integer          not null, primary key
#  title       :string
#  due_term    :integer
#  description :text
#  type        :integer
#  icon        :string
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MilestoneTemplate < ActiveRecord::Base

  has_many :resources
  belongs_to :category
end
