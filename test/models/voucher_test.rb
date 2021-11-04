# == Schema Information
# Schema version: 20211104055535
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
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  client_id                 :bigint           not null, indexed, indexed => [swap_id]
#  hotel_id                  :bigint           not null, indexed
#  swap_id                   :bigint           indexed => [client_id], indexed
#  user_id                   :bigint           not null, indexed
#
# Indexes
#
#  index_vouchers_on_client_id              (client_id)
#  index_vouchers_on_client_id_and_swap_id  (client_id,swap_id)
#  index_vouchers_on_hotel_id               (hotel_id)
#  index_vouchers_on_swap_id                (swap_id)
#  index_vouchers_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_1a4d6b99f0  (swap_id => swaps.id)
#  fk_rails_35b9b0ce9d  (client_id => clients.id)
#  fk_rails_3e6ca7b204  (user_id => users.id)
#  fk_rails_4ba6faec0b  (hotel_id => hotels.id)
#
require 'test_helper'

class VoucherTest < ActiveSupport::TestCase
  test "voucher has to be for at least one night" do
    skip('disabled validation for now')
    swap = create(:swap,
      start_date: Date.current.yesterday,
      end_date: Date.current
    )
    assert_equal 1, swap.nights
    assert_equal 0, swap.nights_remaining

    voucher = build_stubbed(:voucher, swap: swap)
    refute voucher.valid?
    assert voucher.errors.key?(:nights)
  end

  test "one voucher per period per client" do
    swap = create(:swap, :future)
    voucher = create(:voucher, swap: swap)
    voucher = build(:voucher, 
      swap: swap, 
      client: voucher.client,
      check_in: swap.start_date,
      check_out: swap.end_date,
    )
    refute voucher.valid?
    assert voucher.errors.key?(:client_id)

    voucher.client = create(:client)
    assert voucher.valid?
  end

  test "voucher dates must be in order" do
    swap = build_stubbed(:swap, :future)
    voucher = build_stubbed(:voucher, 
      swap: swap,
      check_in: swap.end_date,
      check_out: swap.start_date
    )
    refute voucher.valid?
    assert voucher.errors.key? :dates

    voucher.check_in = swap.start_date
    voucher.check_out = swap.end_date
    assert voucher.valid?
  end

  test "check_in/out only during swap period" do
    swap = build_stubbed(:swap, :current)
    voucher = build_stubbed(:voucher, 
      swap: swap,
      check_in: swap.start_date,
      check_out: swap.end_date
    )
    # this doesn't raise because the validation for dates being
    # current or in the future only runs on creation, not save or build
    assert voucher.valid?

    voucher.check_in = swap.start_date - 1
    refute voucher.valid?
    assert voucher.errors.key? :check_in

    voucher.check_out = swap.end_date + 1
    refute voucher.valid?
    assert voucher.errors.key? :check_out
  end

  test "dates must be today or later at creation (no backdated vouchers)" do
    swap = create(:swap, :past)
    assert_raises do
      create(:voucher, 
        swap: swap, 
        check_in: swap.start_date, 
        check_out: swap.end_date,
      )
    end

    swap = create(:swap, :current)
    assert_raises do
      create(:voucher, 
        swap: swap, 
        check_in: swap.start_date, 
        check_out: swap.end_date,
      )
    end

    assert_nothing_raised do
      create(:voucher, swap: swap, check_in: Date.current)
    end
  end
end
