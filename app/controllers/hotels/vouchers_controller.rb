class Hotels::VouchersController < Hotels::BaseController
  def show
    @voucher = Voucher.find(params[:id])
    @incidents = @voucher.client.incident_reports.where(hotel: current_user.hotels)
    @incident_report = IncidentReport.new

    @client = @voucher.client
    @hotels = Hotel.all

    @flagged_here = @voucher.hotel.in?(@client.flagged_hotels)
  end
end
