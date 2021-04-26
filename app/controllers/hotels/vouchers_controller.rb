class Hotels::VouchersController < Hotels::BaseController 
  def show
    @voucher = Voucher.find(params[:id])
  end
end