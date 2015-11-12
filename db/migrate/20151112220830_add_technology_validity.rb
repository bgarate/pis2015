class AddTechnologyValidity < ActiveRecord::Migration
  def change
    change_table :technologies do |t|
      t.boolean :validity, default: true, null: false
    end
  end
end
