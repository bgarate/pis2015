class Mentorship < ActiveRecord::Base
  belongs_to :mentor, :class_name => "Person" , :foreign_key => 'mentor_id'# este es el mentor
  belongs_to :mentee, :class_name => "Person" , :foreign_key => 'mentee_id' #este es el discípulo
end

