# == Schema Information
#
# Table name: resources
#
#  id           :integer          not null, primary key
#  doc_id       :string
#  title        :string
#  url          :string
#  milestone_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Resource < ActiveRecord::Base
  belongs_to :milestone
  has_one :template
end
