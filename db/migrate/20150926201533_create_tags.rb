class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|

      t.string   :name
    end

    create_table :tags_milestones, id: false, force: :cascade do |t|
      t.belongs_to :tags, index: true
      t.belongs_to :milestones, index: true

    end

#    add_foreign_key :tag_milestones, :tags
#    add_foreign_key :tag_milestones, :milestones
  end
end
