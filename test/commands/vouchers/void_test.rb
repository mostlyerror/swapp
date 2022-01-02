require 'test_helper'

class Vouchers::VoidTest < ActiveSupport::TestCase
  setup do
    voucher = create(:voucher)
    user = create(:user)
    command = Vouchers::Void.run!(voucher: voucher, user: user)
  end

  test "assigns voided_at and voided_by columns" do
  end

  test "returns early if voucher already voided" do
  end
end
