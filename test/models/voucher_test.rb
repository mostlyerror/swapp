require 'test_helper'

class VoucherTest < ActiveSupport::TestCase
  test '.voided scope returns voided vouchers only' do
    user = create(:user)
    voucher = create(:voucher)
    assert_equal 0, Voucher.voided.size
    voucher.void! user
    assert_equal 1, Voucher.voided.size
  end

  test '#void! sets voided_by' do
    user = create(:user)
    voucher = create(:voucher)
    voucher.void! user
    assert_equal voucher.voided_by, user
  end

  test 'one voucher per period per client' do
    swap = create(:swap, :future)
    first_voucher = create(:voucher, swap: swap)
    second_voucher = build(:voucher, swap: swap, client: first_voucher.client)

    assert_not second_voucher.valid?
    assert second_voucher.errors.key?(:client)

    second_voucher.client = create(:client)
    assert second_voucher.valid?
  end

  test 'more than one voucher per period per client if other vouchers are voided' do
    user = create(:user)
    swap = create(:swap, :future)
    first_voucher = create(:voucher, swap: swap)
    second_voucher = build(:voucher, swap: swap, client: first_voucher.client)

    assert_not second_voucher.valid?
    first_voucher.void! user
    assert second_voucher.valid?
  end

  test 'voucher dates must be in order' do
    swap = build_stubbed(:swap, :future)
    voucher =
      build_stubbed(
        :voucher,
        swap: swap,
        check_in: swap.end_date,
        check_out: swap.start_date,
      )
    assert_not voucher.valid?
    assert voucher.errors.key? :dates

    voucher.check_in = swap.start_date
    voucher.check_out = swap.end_date
    assert voucher.valid?
  end

  test 'check_in/out only during swap period' do
    swap = build_stubbed(:swap, :current)
    voucher =
      build_stubbed(
        :voucher,
        swap: swap,
        check_in: swap.start_date,
        check_out: swap.end_date,
      )

    # this doesn't raise because the validation for dates being
    # current or in the future only runs on creation, not save or build
    assert voucher.valid?

    voucher.check_in = swap.start_date - 1
    assert_not voucher.valid?
    assert voucher.errors.key? :check_in

    voucher.check_out = swap.end_date + 1
    assert_not voucher.valid?
    assert voucher.errors.key? :check_out
  end

  test 'dates must be today or later at creation (no backdated vouchers)' do
    swap = create(:swap, :past)
    assert_raises do
      create(
        :voucher,
        swap: swap,
        check_in: swap.start_date,
        check_out: swap.end_date,
      )
    end

    swap = create(:swap, :current)
    assert_raises do
      create(
        :voucher,
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
