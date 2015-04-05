class AddAddressDetailsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :state, :string
    add_column :orders, :country, :string
    add_column :orders, :zipcode, :string
  end
end
