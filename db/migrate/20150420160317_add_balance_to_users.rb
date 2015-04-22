class AddBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :balance, :decimal, default: 0.00, precision: 10, scale: 2
  end
end
