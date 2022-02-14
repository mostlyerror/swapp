# == Schema Information
# Schema version: 20220113040804
#
# Table name: vouchers
#
#  id                        :bigint           not null, primary key
#  check_in                  :date             not null
#  check_out                 :date             not null
#  guest_ids                 :integer          default([]), is an Array
#  notes                     :text
#  num_adults_in_household   :integer
#  num_children_in_household :integer
#  number                    :string
#  voided_at                 :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  client_id                 :bigint           not null, indexed, indexed => [swap_id]
#  hotel_id                  :bigint           not null, indexed
#  swap_id                   :bigint           indexed => [client_id], indexed
#  user_id                   :bigint           not null, indexed
#  voided_by_id              :bigint           indexed
#
# Indexes
#
#  index_vouchers_on_client_id              (client_id)
#  index_vouchers_on_client_id_and_swap_id  (client_id,swap_id)
#  index_vouchers_on_hotel_id               (hotel_id)
#  index_vouchers_on_swap_id                (swap_id)
#  index_vouchers_on_user_id                (user_id)
#  index_vouchers_on_voided_by_id           (voided_by_id)
#
# Foreign Keys
#
#  fk_rails_1a4d6b99f0  (swap_id => swaps.id)
#  fk_rails_1ea81e504c  (hotel_id => hotels.id)
#  fk_rails_35b9b0ce9d  (client_id => clients.id)
#  fk_rails_3e6ca7b204  (user_id => users.id)
#  fk_rails_8c1008a5cb  (voided_by_id => users.id)
#
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
    @swap.availabilities.create(hotel_id: @hotel.id, vacant: 1, date: Date.today)

    assert_difference("ShortIntake.count") do
      assert_difference("Voucher.count") { post vouchers_url, params: create_params }
    end

    assert_redirected_to voucher_created_url(Voucher.last)
  end

  test "should not issue vouchers without correct vacancy" do
    # no vacancies
    @swap.availabilities.destroy_all
    assert_no_difference("Voucher.count") { post vouchers_url, params: create_params }

    # no vacancy for specific hotel
    @swap.availabilities.create(hotel: create(:hotel), vacant: 1, date: Date.today)
    assert_no_difference("Voucher.count") { post vouchers_url, params: create_params }

    # vacancy for specific hotel
    @swap.availabilities.create(hotel: @hotel, vacant: 1, date: Date.today)
    assert_difference("Voucher.count") { post vouchers_url, params: create_params }

    # vacancy reduced to 0
    assert_no_difference("Voucher.count") { post vouchers_url, params: create_params }
  end

  test "should default vehicle to false if not received" do
    @swap.availabilities.create(hotel_id: @hotel.id, vacant: 1, date: Date.today)
    without_vehicle = create_params.dup
    without_vehicle["voucher"]["short_intake"]["vehicle"] = nil

    assert_difference("Voucher.count") { post vouchers_url, params: without_vehicle }
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
