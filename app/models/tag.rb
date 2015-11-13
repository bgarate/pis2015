# == Schema Information
#
# Table name: tags
#
#  id       :integer          not null, primary key
#  name     :string
#  validity :boolean          default(TRUE), not null
#

class Tag < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :milestones, -> { distinct }
  has_and_belongs_to_many :templates, -> { distinct }
end
