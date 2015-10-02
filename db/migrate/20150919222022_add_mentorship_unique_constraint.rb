class AddMentorshipUniqueConstraint < ActiveRecord::Migration
  def change
    add_index :mentorships, [:mentee_id, :mentor_id], :unique => true
  end
end
