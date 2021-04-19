class Hotels::HomeController < Hotels::BaseController
  def index
    @vouchers = Voucher
      .where(hotel: current_user.hotel)
      .order(created_at: :desc)
      .limit(60)
  end

  def show
    @client = Client.find(params[:id])
    @hotels = Hotel.all
    @flag_hotel_ids = @client.hotels.pluck(:id)
    @flagged_stamps = RedFlag.where(client: @client).pluck(:created_at)
    @incident_report = IncidentReport.new
  end
end
