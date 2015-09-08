class CreateTechRoles < ActiveRecord::Migration
  def change
    create_table :tech_roles do |t|
      t.string :name
      t.string :icon

      t.timestamps null: false
    end
  end
end
