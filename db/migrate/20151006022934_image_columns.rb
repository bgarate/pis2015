class ImageColumns < ActiveRecord::Migration
  def change
    change_table :people do |t|
      t.string :image_id
    end
  end
end
