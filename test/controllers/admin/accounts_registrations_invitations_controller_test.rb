require 'test_helper'

class Dashboard::BrandsControllerTest < ActionController::TestCase

  setup do
    @dashboard_brands_store = dashboard_brands_stores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dashboard_brands_stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dashboard_brands_store" do
    assert_difference('Dashboard::BrandsStore.count') do
      post :create, dashboard_brands_store: {  }
    end

    assert_redirected_to dashboard_brands_store_path(assigns(:dashboard_brands_store))
  end

  test "should show dashboard_brands_store" do
    get :show, id: @dashboard_brands_store
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dashboard_brands_store
    assert_response :success
  end

  test "should update dashboard_brands_store" do
    patch :update, id: @dashboard_brands_store, dashboard_brands_store: {  }
    assert_redirected_to dashboard_brands_store_path(assigns(:dashboard_brands_store))
  end

  test "should destroy dashboard_brands_store" do
    assert_difference('Dashboard::BrandsStore.count', -1) do
      delete :destroy, id: @dashboard_brands_store
    end

    assert_redirected_to dashboard_brands_stores_path
  end
end
