class CreatePersonSkills < ActiveRecord::Migration
  def change
    create_table :person_skills do |t|
      t.date :since_date

      t.timestamps null: false
    end
  end
end
