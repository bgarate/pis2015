# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :integer
#  project_id :integer
#

class Participation < ActiveRecord::Base
  belongs_to :person
  belongs_to :project
end
