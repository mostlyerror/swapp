require 'test_helper'

class VoucherTest < ActiveSupport::TestCase
  test "voucher has to be for at least one night" do
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
