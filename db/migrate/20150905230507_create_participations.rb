class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
