class Mentorship < ActiveRecord::Base
  belongs_to :mentor, :class_name => "Person" # este es el mentor
  belongs_to :mentee, :class_name => "Person" # este es el discípulo
end

