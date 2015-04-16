require 'test_helper'

class CashoutsControllerTest < ActionController::TestCase
  setup do
    @cashout = cashouts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cashouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cashout" do
    assert_difference('Cashout.count') do
      post :create, cashout: { amount: @cashout.amount, user_id: @cashout.user_id }
    end

    assert_redirected_to cashout_path(assigns(:cashout))
  end

  test "should show cashout" do
    get :show, id: @cashout
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cashout
    assert_response :success
  end

  test "should update cashout" do
    patch :update, id: @cashout, cashout: { amount: @cashout.amount, user_id: @cashout.user_id }
    assert_redirected_to cashout_path(assigns(:cashout))
  end

  test "should destroy cashout" do
    assert_difference('Cashout.count', -1) do
      delete :destroy, id: @cashout
    end

    assert_redirected_to cashouts_path
  end
end
