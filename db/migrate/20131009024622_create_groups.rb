class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :project_id, null: false

      t.timestamps
    end
  end
end
