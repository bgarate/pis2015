class AddTemplateDoc < ActiveRecord::Migration
  def change
    change_table :templates do |m|
      m.belongs_to :resource
    end
  end
end