class AddMilestoneStartDate < ActiveRecord::Migration
  def change
    change_table :milestones do |m|
      m.date :start_date
    end	
  end
end

