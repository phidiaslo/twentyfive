class AddExtraIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :gig_id, :integer
    add_column :orders, :buyer_id, :integer
    add_column :orders, :seller_id, :integer
  end
end
