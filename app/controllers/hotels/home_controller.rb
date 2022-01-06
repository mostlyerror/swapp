class Hotels::HomeController < Hotels::BaseController
  def index
    @hotel = current_user.hotel
    @vouchers = Voucher
      .includes(client: [:flagged_hotels])
      .where(hotel: current_user.hotels)
      .order(created_at: :desc)
      .limit(100)
  end

  def show
    @client = Client.find(params[:id])
    @hotels = Hotel.all
    @flag_hotel_ids = @client.hotels.pluck(:id)
    @flagged_stamps = RedFlag.where(client: @client).pluck(:created_at)
    @incident_report = IncidentReport.new

    @incident_reports = @client.incident_reports.order(created_at: :desc).select do |ir|
      current_user.admin_user? || current_user == ir.reporter
    end
  end
end
