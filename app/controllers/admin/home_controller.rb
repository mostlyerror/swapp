class Admin::HomeController < Admin::BaseController
  def index
    @swap = Swap.current
    @vouchers = Voucher.order(created_at: :desc).all

    if SwapIntake.can_issue_voucher_today?(@swap)
      @supply = RoomSupply.by_motel(@swap)
      @motel_map = Motel.all.pluck(:id, :name).to_h
    end
  end
end
