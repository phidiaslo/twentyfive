class AddCityToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :city, :string
  end
end
