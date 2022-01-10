# == Schema Information
# Schema version: 20211103053452
#
# Table name: clients
#
#  id                       :bigint           not null, primary key
#  banned                   :boolean          default(FALSE)
#  date_of_birth            :date
#  email                    :string
#  ethnicity                :string
#  family_members           :jsonb
#  first_name               :string           not null
#  force_intake             :boolean          default(FALSE)
#  gender                   :string
#  last_name                :string           not null
#  phone_number             :string
#  race                     :jsonb
#  veteran                  :boolean
#  veteran_discharge_status :string
#  veteran_military_branch  :string
#  veteran_separation_year  :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require 'test_helper'

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

  test 'should create short_intake and voucher' do
    assert_difference('Voucher.count') do
      post vouchers_url, params: create_params
    end

    assert_redirected_to voucher_created_url(Voucher.last)
  end

  private

  def create_params
    {
      'authenticity_token' =>
        '+PycsQReoQiMT+kjaAPqu/PO99UHswv7r5hOEhgHYZu9xJ7znVzdsDufMTB7TZKZbhrhI2MdrQo+QMKsE21rXg==',
      'voucher' => {
        'short_intake' => {
          'where_did_you_sleep_last_night' => 'In own home',
          'what_city_did_you_sleep_in_last_night' => 'qwer',
          'why_not_shelter' => ['Safety concerns', '0'],
          'pets' => 'Yes. A dog that WILL NOT stay with me in the hotel',
          'identification' => 'Yes, SWAP ID',
        },
        'check_in' => @swap.start_date,
        'check_out' => @swap.end_date,
        'hotel_id' => @hotel.id,
        'client' => {
          'id' => @client.id,
          'phone_number' => '',
          'email' => '',
        },
      },
      'commit' => 'Create Voucher',
    }
  end
end
