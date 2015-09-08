class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :cellphone
      t.string :phone
      t.date :birth_date
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
