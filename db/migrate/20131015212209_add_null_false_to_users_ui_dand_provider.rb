class AddNullFalseToUsersUiDandProvider < ActiveRecord::Migration
  def up
    change_column :users, :provider, :string, null: false
    change_column :users, :uid, :string, null: false
  end

  def down
    change_column :users, :provider, :string
    change_column :users, :uid, :string
  end
end
