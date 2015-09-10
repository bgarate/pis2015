class AddTechRolePerson < ActiveRecord::Migration
  def change
    add_reference :people, :tech_role, references: :tech_roles
    add_foreign_key :people, :tech_roles, column: :tech_role_id
  end
end
