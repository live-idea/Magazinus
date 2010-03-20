require 'test_helper'

class GoodsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create good" do
    assert_difference('Good.count') do
      post :create, :good => { }
    end

    assert_redirected_to good_path(assigns(:good))
  end

  test "should show good" do
    get :show, :id => goods(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => goods(:one).to_param
    assert_response :success
  end

  test "should update good" do
    put :update, :id => goods(:one).to_param, :good => { }
    assert_redirected_to good_path(assigns(:good))
  end

  test "should destroy good" do
    assert_difference('Good.count', -1) do
      delete :destroy, :id => goods(:one).to_param
    end

    assert_redirected_to goods_path
  end
end
