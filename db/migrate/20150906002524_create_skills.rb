class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :type
      t.string :icon

      t.timestamps null: false
    end
  end
end
