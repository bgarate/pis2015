class CreateTechRols < ActiveRecord::Migration
  def change
    create_table :tech_rols do |t|
      t.string :tech_rol_name
      t.string :icon

      t.timestamps null: false
    end
  end
end
