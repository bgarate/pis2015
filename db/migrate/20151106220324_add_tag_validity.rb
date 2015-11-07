class AddTagValidity < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.boolean :validity, default: true, null: false
    end
  end
end
