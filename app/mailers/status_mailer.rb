class StatusMailer < ActionMailer::Base
  default from: "TwentyFive.com <no-reply@twentyfive.com>"

  def notification_to_buyer(buyer, order)
	@buyer = buyer
	@order = order

	mail(
	  to: "#{@buyer.email}",
	  subject: "[25] Your order status has been updated to '#{@order.status}'"
	  )
  end

  def notification_to_seller(seller, order)
	@seller = seller
	@order = order

	mail(
	  to: "#{@seller.email}",
	  subject: "[25] The Buyer has confirmed this order's completion"
	  )
  end

  def invoice_to_buyer(buyer, order)
	@buyer = buyer
	@order = order

	mail(
	  to: "#{@buyer.email}",
	  subject: "[25] Thank you for your order"
	  )
  end

end
