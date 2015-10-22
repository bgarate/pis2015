# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :milestones

  HIST0RY_NAME = 'Historial'
  HISTORY_ICON = 'glyphicon-time'

  def self.get_or_create_history_category

    history_category = Category.find_by(name: HIST0RY_NAME)

    if history_category == nil
      history_category = Category.new
      history_category.name = HIST0RY_NAME
      history_category.icon = HISTORY_ICON
      history_category.save!
    end

    history_category

  end

end
