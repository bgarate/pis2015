class AddPersonMentorships < ActiveRecord::Migration
  def change
    add_reference :mentorships, :mentor, references: :people, index:true
    add_foreign_key :mentorships, :people, column: :mentor_id
    add_reference :mentorships, :mentee, references: :people, index:true
    add_foreign_key :mentorships, :people, column: :mentee_id
  end
end
