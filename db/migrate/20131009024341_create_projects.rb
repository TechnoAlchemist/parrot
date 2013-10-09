class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :link, null: false
      t.integer :cohort_id, null: false

      t.timestamps
    end
  end
end
