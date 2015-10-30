# == Schema Information
#
# Table name: templates
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  icon        :string
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resource_id :integer
#

class Template < ActiveRecord::Base

  belongs_to :resource
  belongs_to :category
  has_and_belongs_to_many :tags

end
