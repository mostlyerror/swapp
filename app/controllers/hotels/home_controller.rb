class Hotels::HomeController < Hotels::BaseController
  def index
    @vouchers = Voucher.order(created_at: :desc).limit(60)
  end

  def show
    @client = Client.find(params[:id])
  end
end
