class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :term, null: false

      t.timestamps
    end
  end
end
