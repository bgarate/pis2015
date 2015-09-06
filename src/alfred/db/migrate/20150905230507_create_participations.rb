class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.date :init_date
      t.date :finish_date

      t.timestamps null: false
    end
  end
end
