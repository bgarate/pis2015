# == Schema Information
#
# Table name: mentorships
#
#  id         :integer          not null, primary key
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  mentor_id  :integer
#  mentee_id  :integer
#

class Mentorship < ActiveRecord::Base
  belongs_to :mentor, :class_name => 'Person' , :foreign_key => 'mentor_id'# este es el mentor
  belongs_to :mentee, :class_name => 'Person' , :foreign_key => 'mentee_id' #este es el discípulo
end

