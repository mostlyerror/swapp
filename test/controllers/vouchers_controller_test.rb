require "test_helper"

class VouchersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in create(:user)

    @hotel = create(:hotel)
    @swap = create(:swap, :current)
    @client = create(:client)

    Timecop.travel(@swap.intake_dates.first)
  end

  teardown { Timecop.return }

  test "should create short_intake and voucher" do
    assert_difference("ShortIntake.count") do
      assert_difference("Voucher.count") do
        post vouchers_url, params: create_params
      end
    end

    assert_redirected_to voucher_created_url(Voucher.last)
  end

  test "should default vehicle to false if not received" do
    without_vehicle = create_params.dup
    without_vehicle["voucher"]["short_intake"]["vehicle"] = nil

    post vouchers_url, params: without_vehicle

    assert_redirected_to voucher_created_url(Voucher.last)
    assert_equal false, ShortIntake.last.vehicle
  end

  private

  def create_params
    {
      "voucher" => {
        "short_intake" => {
          "where_did_you_sleep_last_night" => "In own home",
          "what_city_did_you_sleep_in_last_night" => "qwer",
          "why_not_shelter" => ["Safety concerns", "0"],
          "pets" => "Yes. A dog that WILL NOT stay with me in the hotel",
          "vehicle" => "Yes",
          "identification" => "Yes, SWAP ID"
        },
        "check_in" => @swap.start_date,
        "check_out" => @swap.end_date,
        "hotel_id" => @hotel.id,
        "client" => {
          "id" => @client.id,
          "phone_number" => "",
          "email" => ""
        }
      },
      "commit" => "Create Voucher"
    }
  end
end
