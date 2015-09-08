class CreateMilestoneTemplates < ActiveRecord::Migration
  def change
    create_table :milestone_templates do |t|
      t.string :title
      t.integer :due_term #plazo de vencimiento
      t.text :description
      t.integer :type #tipo de creación del hito
      t.string :icon
      t.belongs_to :category

      t.timestamps null: false
    end
  end
end
