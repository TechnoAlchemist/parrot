class AddPairsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pairs, :text, default: []
  end
end
