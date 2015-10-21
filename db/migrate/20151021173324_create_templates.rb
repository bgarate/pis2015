class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :title
      t.text :description
      t.string :icon
      t.belongs_to :category

      t.timestamps null: false
    end

    add_foreign_key :templates, :categories

    create_table :templates_tags, id: false, force: :cascade do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :template, index: true

    end

    add_index :templates_tags, [:tag_id, :template_id], :unique => true
    add_foreign_key :templates_tags, :tags
    add_foreign_key :templates_tags, :templates
  end
end
