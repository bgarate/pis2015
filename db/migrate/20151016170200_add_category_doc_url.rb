class AddCategoryDocUrl < ActiveRecord::Migration
  def change
    change_table :categories do |m|
      m.string :doc_url
    end
  end
end