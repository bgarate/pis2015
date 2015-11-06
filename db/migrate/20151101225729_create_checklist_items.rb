class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.text :description
      t.boolean :checked
      t.belongs_to :checklist, index: true

      t.timestamps null: false
    end
  end
end
