class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :url
      t.belongs_to :milestone, index: true

      t.timestamps null: false
    end
  end
end
