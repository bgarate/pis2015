class AddParticipationRels < ActiveRecord::Migration
  def change
    add_reference :participations, :person, references: :people, index:true
    add_foreign_key :participations, :people, column: :person_id
    add_reference :participations, :project, references: :projects, index:true
    add_foreign_key :participations, :projects, column: :project_id
  end
end
