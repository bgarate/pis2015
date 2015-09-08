class AddPersonSkillRel < ActiveRecord::Migration
  def change
    add_reference :person_skills, :person, references: :people, index:true
    add_foreign_key :person_skills, :people, column: :person_id
    add_reference :person_skills, :skill, references: :skills, index:true
    add_foreign_key :person_skills, :skills, column: :skill_id
  end
end
