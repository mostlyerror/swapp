class Admin::HomeController < Admin::BaseController
  def index
    @swap = Swap.current
    @vouchers = Voucher.order(created_at: :desc).all
    @availability = RoomAvailability.by_motel(@swap)
  end
end
