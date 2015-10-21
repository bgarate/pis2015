class AddCategoryIsFeedback < ActiveRecord::Migration
  def change
    change_table :categories do |m|
      m.boolean :is_feedback
    end
  end
end