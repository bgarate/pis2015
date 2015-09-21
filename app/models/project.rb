# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  start_date :date
#  end_date   :date
#  client     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  has_and_belongs_to_many :technologies, autosave: true
  has_many :participations
  has_many :people, through: :participations

  enum status:[:active, :inactive, :finished]

  def display_status
    I18n.t("project.display_status.#{status}", default: status.titleize)
  end

  def self.status_names_for_select
    names = []
    statuses.keys.each do |status|
      display_name = I18n.t("project.display_status.#{status}", default: status.titleize)
      names << [display_name, status]
    end
    names
  end

end
