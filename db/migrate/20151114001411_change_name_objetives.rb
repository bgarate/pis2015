class ChangeNameObjetives < ActiveRecord::Migration
  def change
    rename_table :checklist_items, :objectives
  end
end
