class Admin::HomeController < Admin::BaseController
  def index
    @swap = Swap.current
    @motel_map = Motel.all.pluck(:id, :name).to_h
    @supply = RoomSupply.by_motel(@swap)
    @vouchers = Voucher.order(created_at: :desc).all
  end
end
