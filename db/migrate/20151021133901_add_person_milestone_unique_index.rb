class AddPersonMilestoneUniqueIndex < ActiveRecord::Migration
  def change
    add_index :person_milestones, [:person_id, :milestone_id], :unique => true
  end
end
