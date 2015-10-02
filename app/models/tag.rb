# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string
#

class Tag < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :milestones, -> { distinct }

end
