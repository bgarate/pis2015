class AddTechRoleValidity < ActiveRecord::Migration
  def change
    change_table :tech_roles do |t|
      t.boolean :validity, default: true, null: false
    end
  end
end
