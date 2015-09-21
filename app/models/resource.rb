# == Schema Information
#
# Table name: resources
#
#  id           :integer          not null, primary key
#  file_id      :string
#  milestone_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Resource < ActiveRecord::Base
  belongs_to :milestone

end
