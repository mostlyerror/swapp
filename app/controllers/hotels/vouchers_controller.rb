class Hotels::VouchersController < Hotels::BaseController 
  def show
    @voucher = Voucher.find(params[:id])
    @incidents = @voucher.client.incident_reports
    @incident_report = IncidentReport.new
  end
end