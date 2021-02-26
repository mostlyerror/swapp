class Admin::HomeController < Admin::BaseController
  def index
    @swap = Swap.current
    @vouchers = Voucher.order(created_at: :desc).all
    @motel_map = Motel.all.pluck(:id, :name).to_h

    if @swap
      @vouchers_remaining_today = RoomSupply.vouchers_remaining_today(@swap)
      @num_vouchers_remaining_today = RoomSupply.num_vouchers_remaining_today(@swap)
      @supply = RoomSupply.by_motel(@swap)
    end
  end
end
