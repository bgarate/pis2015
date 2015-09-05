class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :celphone
      t.string :phone
      t.date :birth_date
      t.date :init_date
      t.date :finish_date
      t.string :tech_rol

      t.timestamps null: false
    end
  end
end
