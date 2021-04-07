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
    @incident_report = IncidentReport.new

  end

  def create_report
    @incident_report = IncidentReport.new(params[:incident_report])
  end
end
