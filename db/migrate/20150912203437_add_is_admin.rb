class AddIsAdmin < ActiveRecord::Migration
  def change
    change_table :people do |t|

      t.boolean :admin

    end
  end
end
