class Admin::HomeController < Admin::BaseController
  def index
    @swap = Swap.current
    @availability = RoomSupply.by_motel(@swap)
    @vouchers = Voucher.order(created_at: :desc).all
  end
end
