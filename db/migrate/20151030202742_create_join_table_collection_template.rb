class CreateJoinTableCollectionTemplate < ActiveRecord::Migration
  def change
    create_join_table :collections, :templates do |t|
      t.index [:collection_id, :template_id]
      t.integer :days, default:0

      t.timestamps null: false
    end
  end
end
