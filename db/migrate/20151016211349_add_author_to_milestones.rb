class AddAuthorToMilestones < ActiveRecord::Migration
  def change
    change_table :milestones do |m|
      m.belongs_to :author, class_name: 'Person'
    end
  end
end
