class Note < ActiveRecord::Base
  enum visibility: [:private, :mentors, :all]
  has_one :autor, :class_name => "Person"
end
