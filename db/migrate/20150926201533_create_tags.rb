class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|

      t.string   :name
    end

    create_table :milestones_tags, id: false, force: :cascade do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :milestone, index: true

    end

#    add_foreign_key :tag_milestones, :tags
#    add_foreign_key :tag_milestones, :milestones
  end
end
