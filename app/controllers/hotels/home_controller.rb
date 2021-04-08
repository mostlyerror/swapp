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
    @incident_report = IncidentReport.new
  end

  def create_report
    @incident_report = IncidentReport.new(incident_report_params)

    if @incident_report.save
      redirect_to show_client_path, notice: "New report created"
    else
      render :new
    end
  end


  private
  
  def incident_report_params
    params.require(:incident_report).permit(:description)
  end
end
