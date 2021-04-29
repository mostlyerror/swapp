class Hotels::VouchersController < Hotels::BaseController 
  def show
    @voucher = Voucher.find(params[:id])
    @incidents = @voucher.client.incident_reports
    @incident_report = IncidentReport.new

    @client = @voucher.client
    @hotels = Hotel.all
    @flag_hotel_ids = @client.hotels.pluck(:id)
    @flagged_here = @voucher.hotel.id.in?(@flag_hotel_ids)
    # @flagged_stamps = RedFlag.where(client: @client).pluck(:created_at)
  end
end