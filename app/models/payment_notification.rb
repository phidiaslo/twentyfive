class PaymentNotification < ActiveRecord::Base
	belongs_to :order
	belongs_to :customer_order
	serialize :params
	after_create :mark_order_as_completed

	private

	def mark_order_as_completed
	  if status == "Completed"
	    customer_order.update_attributes(purchased_at: Time.now, status: 'Pending', payment_status: 'Paid', transaction_id: transaction_id, notification_params: params)
	    customer_order.send_invoice_to_buyer
	  end
	end
end
