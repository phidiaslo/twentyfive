class AddLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :level, :string, :null => false, :default => 'New Seller'
  end
end
