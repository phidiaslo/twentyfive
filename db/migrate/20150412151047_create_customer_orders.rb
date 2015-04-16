class CreateCustomerOrders < ActiveRecord::Migration
  def change
    create_table :customer_orders do |t|
      t.string :name
      t.string :address_one
      t.string :address_two
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :email
      t.text :remarks
      t.integer :gig_id
      t.integer :buyer_id
      t.integer :seller_id
      t.string :payment_status
      t.text :notification_params
      t.string :status
      t.string :transaction_id
      t.datetime :purchased_at

      t.timestamps null: false
    end
  end
end
