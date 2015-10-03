class AddUniqueIndexForEmailInPeople < ActiveRecord::Migration
  def change
    add_index "people", ["email"], name: "index_people_on_email", unique: true
  end
end
