class AddProjectValidity < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.boolean :validity, default: true, null: false
    end
  end
end
