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
    @flag_hotel_ids = RedFlag.where(client: @client).pluck(:hotel_id)
    @flagged_stamps = RedFlag.where(client: @client).pluck(:created_at)
    @incident_report = IncidentReport.new
  end

  def create_report
    @client = Client.find(params[:id])
    @incident_report = IncidentReport.new(incident_report_params)

    @incident_report.client_id = @client.id
    @incident_report.reporter_id = current_user.id

    if @incident_report.save
      redirect_to hotels_show_client_path(id: @client)
    end
  end


  private
  def incident_report_params
    params.require(:incident_report).permit(:occurred_at, :description)
  end
end
