class AddProjectStatus < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.integer :status, default: 0, null: false
    end
  end
end
