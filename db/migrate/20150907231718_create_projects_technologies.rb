class CreateProjectsTechnologies < ActiveRecord::Migration
  def change
    create_table :projects_technologies do |t|

      t.belongs_to :project, index: true
      t.belongs_to :technology, index: true

    end
  end
end
