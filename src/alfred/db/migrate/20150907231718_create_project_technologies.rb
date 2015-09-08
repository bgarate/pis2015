class CreateProjectTechnologies < ActiveRecord::Migration
  def change
    create_table :project_technologies do |t|

      t.belongs_to :project, index: true
      t.belongs_to :technology, index: true

    end
  end
end
