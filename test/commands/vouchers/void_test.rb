require 'test_helper'

class Vouchers::VoidTest < ActiveSupport::TestCase
  setup do
    swap = create(:swap)
    hotel = create(:hotel)
    swap.availabilities.create(hotel: hotel, vacant: 1, date: Date.current)

    @voucher = create(:voucher, hotel: hotel)
    @user = create(:user)
  end

  test 'assigns voided_at and voided_by columns' do
    assert_equal false, @voucher.voided?
    assert_nil @voucher.voided_at

    @command = Vouchers::Void.run!(voucher: @voucher, user: @user)
    assert_equal true, @command

    assert_equal true, @voucher.voided?
    assert_equal @user, @voucher.voided_by
  end

  test 'NOOP if voucher already voided' do
    @voucher.void!(@user)
    assert_equal true, @voucher.voided?

    @command = Vouchers::Void.run!(voucher: @voucher, user: @user)
    assert_nil @command
    assert_equal true, @voucher.voided?
  end
end
