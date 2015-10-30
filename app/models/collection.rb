# == Schema Information
#
# Table name: collections
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  icon        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Collection < ActiveRecord::Base

  has_many :templates
end
