require 'test_helper'

class UserCreditsControllerTest < ActionController::TestCase
  setup do
    @user_credit = user_credits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_credits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_credit" do
    assert_difference('UserCredit.count') do
      post :create, user_credit: { credit: @user_credit.credit, item_id: @user_credit.item_id, user_id: @user_credit.user_id }
    end

    assert_redirected_to user_credit_path(assigns(:user_credit))
  end

  test "should show user_credit" do
    get :show, id: @user_credit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_credit
    assert_response :success
  end

  test "should update user_credit" do
    patch :update, id: @user_credit, user_credit: { credit: @user_credit.credit, item_id: @user_credit.item_id, user_id: @user_credit.user_id }
    assert_redirected_to user_credit_path(assigns(:user_credit))
  end

  test "should destroy user_credit" do
    assert_difference('UserCredit.count', -1) do
      delete :destroy, id: @user_credit
    end

    assert_redirected_to user_credits_path
  end
end
