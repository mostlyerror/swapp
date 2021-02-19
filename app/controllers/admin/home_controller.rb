class Admin::HomeController < Admin::BaseController
  def index
    @current = SwapPeriod.current
    @vouchers = Voucher.order(created_at: :desc).all
  end
end
