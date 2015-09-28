class AddMilestoneStatusDefault < ActiveRecord::Migration
  def change
    change_column(:milestones, :status, :integer, :default => 0)
  end
end
