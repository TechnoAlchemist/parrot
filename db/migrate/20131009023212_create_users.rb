class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :username, null: false
      t.string :role, null: false, role: 'student'
      t.integer :cohort_id

      t.timestamps
    end
  end
end
