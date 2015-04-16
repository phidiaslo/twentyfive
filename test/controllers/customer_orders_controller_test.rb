require 'test_helper'

class CustomerOrdersControllerTest < ActionController::TestCase
  setup do
    @customer_order = customer_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_order" do
    assert_difference('CustomerOrder.count') do
      post :create, customer_order: { address_one: @customer_order.address_one, address_two: @customer_order.address_two, buyer_id: @customer_order.buyer_id, city: @customer_order.city, country: @customer_order.country, email: @customer_order.email, gig_id: @customer_order.gig_id, name: @customer_order.name, notification_params: @customer_order.notification_params, payment_status: @customer_order.payment_status, purchased_at: @customer_order.purchased_at, remarks: @customer_order.remarks, seller_id: @customer_order.seller_id, state: @customer_order.state, status: @customer_order.status, transaction_id: @customer_order.transaction_id, zipcode: @customer_order.zipcode }
    end

    assert_redirected_to customer_order_path(assigns(:customer_order))
  end

  test "should show customer_order" do
    get :show, id: @customer_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_order
    assert_response :success
  end

  test "should update customer_order" do
    patch :update, id: @customer_order, customer_order: { address_one: @customer_order.address_one, address_two: @customer_order.address_two, buyer_id: @customer_order.buyer_id, city: @customer_order.city, country: @customer_order.country, email: @customer_order.email, gig_id: @customer_order.gig_id, name: @customer_order.name, notification_params: @customer_order.notification_params, payment_status: @customer_order.payment_status, purchased_at: @customer_order.purchased_at, remarks: @customer_order.remarks, seller_id: @customer_order.seller_id, state: @customer_order.state, status: @customer_order.status, transaction_id: @customer_order.transaction_id, zipcode: @customer_order.zipcode }
    assert_redirected_to customer_order_path(assigns(:customer_order))
  end

  test "should destroy customer_order" do
    assert_difference('CustomerOrder.count', -1) do
      delete :destroy, id: @customer_order
    end

    assert_redirected_to customer_orders_path
  end
end
