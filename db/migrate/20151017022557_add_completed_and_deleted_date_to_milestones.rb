class AddCompletedAndDeletedDateToMilestones < ActiveRecord::Migration
  def change
    change_table :milestones do |m|
      m.date :completed_date
      m.date :deleted_date
    end
  end
end
