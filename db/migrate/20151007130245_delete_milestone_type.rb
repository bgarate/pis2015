class DeleteMilestoneType < ActiveRecord::Migration
  def change

    remove_column :milestones,:milestone_type

  end
end