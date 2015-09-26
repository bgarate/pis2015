class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags, force: :cascade do |t|
      t.string   :name
    end

    create_table :tag_milestones, id: false, force: :cascade do |t|
      t.integer   :tag_id
      t.integer   :milestone_id
    end

    add_foreign_key :tag_milestones, :tags
    add_foreign_key :tag_milestones, :milestones
  end
end
