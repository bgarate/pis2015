class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :tech_name
      t.string :icon

      t.timestamps null: false
    end
  end
end
