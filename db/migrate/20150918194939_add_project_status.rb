class AddProjectStatus < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.integer :status
    end
  end
end
