require 'test_helper'

class Dashboard::StoresControllerTest < ActionController::TestCase
  setup do
    @controller = Dashboard::StoresController.new
    @store = stores(:primos_head)
  end

  test 'should get index' do
    get :index,  brand_id: @store.brand
    assert_response :success
    assert_not_nil assigns(:dashboard_brand_stores)
  end

=begin
  describe BrandStore do
    describe "#full_name" do
      it r'is composed of first and last name' do
        store = brands_stores(:primos_head)
        store.brand.name.should eql('nenvi')
      end
    end
  end


  test 'should get edit' do
    get :edit, id: @brand_store, brand_id: @brand_store.brand, :brands => {}
    assert_response :success
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:dashboard_brands_stores)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create dashboard_brands_store' do
    assert_difference('BrandStore.count') do
      post :create, dashboard_brands_store: {}
    end

    assert_redirected_to dashboard_brands_store_path(assigns(:dashboard_brands_store))
  end

  test 'should show dashboard_brands_store' do
    get :show, id: @brand_store
    assert_response :success
  end


  test "should update dashboard_brands_store" do
    patch :update, id: @brand_store, dashboard_brands_store: {}
    assert_redirected_to dashboard_brand_brand_store_path(assigns(:dashboard_brands_store))
  end

  test "should destroy dashboard_brands_store" do
    assert_difference('BrandStore.count', -1) do
      delete :destroy, id: @brand_store
    end

    assert_redirected_to dashboard_brands_stores_path
  end
=end
end
