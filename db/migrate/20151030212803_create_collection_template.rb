class CreateCollectionTemplate < ActiveRecord::Migration
  def change
    create_table :collection_templates do |t|

      t.belongs_to :collection, index: true
      t.belongs_to :template, index: true
      t.integer :days, default:0

      t.timestamps null: false
    end

    add_foreign_key :collection_templates, :collections
    add_foreign_key :collection_templates, :templates

  end
end
