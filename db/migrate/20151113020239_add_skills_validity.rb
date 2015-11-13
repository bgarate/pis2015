class AddSkillsValidity < ActiveRecord::Migration
  def change
  	change_table :skills do |s|
      s.boolean :validity, default: true, null: false
    end
  end
end
