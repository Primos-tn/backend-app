require 'test_helper'
require 'devise/test_helpers'

class Dashboard::BrandsControllerTest < ActionController::TestCase

  setup do
    include Devise::Test::ControllerHelpers
    @controller = Dashboard::BrandsController.new
    @brand = brands(:nenvi)
    @user = accounts(:business_one)
    sign_in @user
    puts @brand
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:dashboard_brands_stores)
  end
=begin
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create brands' do
    assert_difference('Brand.count') do
      post :create,  brands: {  }
    end

    assert_redirected_to dashboard_brands_path(assigns(:brands))
  end

  test 'should show dashboard_brands_store' do
    get :show, id: @brand
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @brand
    assert_response :success
  end

  test 'should update dashboard_brands_store' do
    patch :update, id: @brand, dashboard_brands_store: {  }
    assert_redirected_to dashboard_brands_store_path(assigns(:dashboard_brands_store))
  end

  test 'should destroy dashboard_brands_store' do
    assert_difference('Brand.count', -1) do
      delete :destroy, id: @brand
    end

    assert_redirected_to dashboard_brands_stores_path
  end
=end
end
