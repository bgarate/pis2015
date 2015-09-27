class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|

      t.string   :name
    end

    create_table :milestones_tags, id: false, force: :cascade do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :milestone, index: true

    end

    add_index :milestones_tags, [:tag_id, :milestone_id], :unique => true
    add_foreign_key :milestones_tags, :tags
    add_foreign_key :milestones_tags, :milestones
  end
end
