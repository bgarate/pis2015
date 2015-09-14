# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  text         :text
#  visibility   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :integer
#  milestone_id :integer
#

class Note < ActiveRecord::Base
  enum visibility: [:me, :mentors, :every_body] #no se pueden usar private ni all porque son palabras reservadas
  belongs_to :author, :class_name => 'Person'
  belongs_to :milestone
end
