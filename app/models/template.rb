# == Schema Information
#
# Table name: milestone_templates
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  icon        :string
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Template < ActiveRecord::Base

  #has_many :resources
  belongs_to :category
  has_and_belongs_to_many :tags
end
