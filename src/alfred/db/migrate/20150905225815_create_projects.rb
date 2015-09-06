class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.date :init_date
      t.date :finish_date
      t.string :client

      t.timestamps null: false
    end
  end
end
