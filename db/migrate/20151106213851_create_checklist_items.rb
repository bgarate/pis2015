class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.timestamps null: false
      t.text :description
      t.boolean :checked
      t.belongs_to :milestone, index: true
    end
  end
end
