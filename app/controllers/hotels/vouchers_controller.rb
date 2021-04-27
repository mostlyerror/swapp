class Hotels::VouchersController < Hotels::BaseController 
  def show
    @voucher = Voucher.find(params[:id])
    @incidents = @voucher.client.incident_reports
  end
end