class AddCustomerOrderIdToPaymentNotifications < ActiveRecord::Migration
  def change
    add_column :payment_notifications, :customer_order_id, :integer
  end
end
