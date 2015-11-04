class DeleteCategoryUrl < ActiveRecord::Migration
  def change

      remove_column :categories,:doc_url

  end
end