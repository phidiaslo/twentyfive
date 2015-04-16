json.array!(@customer_orders) do |customer_order|
  json.extract! customer_order, :id, :name, :address_one, :address_two, :city, :state, :zipcode, :country, :email, :remarks, :gig_id, :buyer_id, :seller_id, :payment_status, :notification_params, :status, :transaction_id, :purchased_at
  json.url customer_order_url(customer_order, format: :json)
end
