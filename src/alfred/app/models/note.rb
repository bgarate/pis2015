class Note < ActiveRecord::Base
  enum visibility: [:me, :mentors, :every_body] #no se pueden usar private ni all porque son palabras reservadas
  belongs_to :author, :class_name => 'Person'
  belongs_to :milestone
end
