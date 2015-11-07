class AddChecklistColumns < ActiveRecord::Migration
  def change
    change_table :checklist_items do |t|
      t.text :description
      t.boolean :checked
      t.belongs_to :checklist, index: true
    end
    change_table :checklists do |c|
      c.belongs_to :project, index: true
    end


  end
end
