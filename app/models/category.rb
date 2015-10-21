# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  icon        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  doc_url     :string
#  is_feedback :boolean
#

class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :milestones
end
