class AddTechRoleNameUniqueIndex < ActiveRecord::Migration
  def change
    add_index 'tech_roles', ['name'], name: 'index_tech_roles_on_name', unique: true
  end
end
