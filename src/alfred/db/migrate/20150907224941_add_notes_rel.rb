class AddNotesRel < ActiveRecord::Migration
  def change
    add_reference :notes, :author, references: :people, index:true
    add_foreign_key :notes, :people, column: :author_id

    add_reference :notes, :milestone, references: :milestones, index:true
    add_foreign_key :notes, :milestones, column: :milestone_id

  end
end
