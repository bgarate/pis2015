class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|

      t.timestamps null: false
    end
  end
end
