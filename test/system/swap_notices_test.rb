# require "application_system_test_case"

# class SwapNoticesTest < ApplicationSystemTestCase
#   include Devise::Test::IntegrationHelpers
#   include DatesHelper

#   setup do
#     user = create(:user)
#     sign_in user
#     hotel = create(:hotel)
#   end

#   test "notice for swap inactive" do
#     visit root_path
#     assert_text /no scheduled swap period/i
#   end

#   test "notice for swap intake start/end" do
#     swap = create(:swap, :tomorrow)
#     visit root_path
#     assert_text /swap is active/i
#     assert_text /#{humanize_date(swap.intake_start_date)} to #{humanize_date(swap.intake_end_date)}/i
#   end

#   test "notice for last intake day" do
#     swap = create(:swap, :current)
#     visit root_path
#     assert_text /today is the last day to issue vouchers/i
#   end

#   test "out of vouchers" do
#     swap = create(:swap, :tomorrow)
#     visit root_path
#     assert_text /no available vouchers/i
#   end
# end
