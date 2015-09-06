class CreateMentorships < ActiveRecord::Migration
  def change
    create_table :mentorships do |t|
      t.date :init_date
      t.date :finish_date

      t.timestamps null: false
    end
  end
end
