class AddCategoryStatus < ActiveRecord::Migration
  def change
    change_table :categories do |m|
      m.integer :status
    end
  end
end