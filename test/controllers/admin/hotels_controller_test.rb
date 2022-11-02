require 'test_helper'

class Admin::HotelsControllerTest < ActionDispatch::IntegrationTest
  # include Devise::ControllerHelpers

  setup do
    @hotel = create(:hotel)
    @user = create(:user, :admin_user)
    # sign_in(@user)
  end

  test "should get index" do
    get admin_hotels_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_hotel_url
    assert_response :success
  end

  test "should create hotel" do
    hotel_params = build(:hotel).attributes.to_h

    assert_difference('Hotel.count') do
      post admin_hotels_url, params: { hotel: hotel_params }
    end

    assert_redirected_to admin_hotel_url(Hotel.last)
  end

  test "should show hotel" do
    get admin_hotel_url(@hotel)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_hotel_url(@hotel)
    assert_response :success
  end

  test "should update hotel" do
    hotel_params = { name: "#{FFaker::Company.name} hotel" }

    patch admin_hotel_url(@hotel), params: { hotel: hotel_params }
    assert_redirected_to admin_hotel_url(@hotel)
  end

  test "should destroy hotel" do
    assert_difference('Hotel.count', -1) do
      delete admin_hotel_url(@hotel)
    end

    assert_redirected_to admin_hotels_url
  end
end
