class AddMilestoneCategoryRelationships < ActiveRecord::Migration
  def change
    add_reference :milestones, :category, references: :categories
    add_foreign_key :milestones, :categories, column: :category_id
  end

end
