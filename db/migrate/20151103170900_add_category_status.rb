class AddCategoryStatus < ActiveRecord::Migration
  def change
    change_table :categories do |m|
      t.integer :status
    end
  end
end