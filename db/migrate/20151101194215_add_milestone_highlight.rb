class AddMilestoneHighlight < ActiveRecord::Migration
  def change
  	change_table :milestones do |m|
  		m.boolean :highlighted, default: false, null: false	
  	end	
  end
end
