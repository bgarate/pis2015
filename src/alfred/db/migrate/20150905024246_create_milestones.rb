class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :title
      t.date :due_date
      t.date :finish_date
      t.text :description
      t.integer :status
      t.integer :type
      t.string :icon

      t.timestamps null: false
    end

    create_table :person_milestones do |t|
      t.belongs_to :person, index: true
      t.belongs_to :milestone, index: true
      t.date :finish_date

      t.timestamps null: false
    end
  end
end