class Note < ActiveRecord::Base
  enum visibility: [:private, :mentors, :all]
  has_one :author, :class_name => "Person"
  belongs_to :milestone
end
