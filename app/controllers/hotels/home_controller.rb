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
    # [ obj1, obj2 ]
    # [1, 2]
    # @flags = RedFlag.where(client_id: @client.id)
    # select * from red_flags where client_id = 12;
    # client_id, hotel_id
    # ------
    # 1, 1 
    # 1, 4
    # 12, 1
    # 12, 2

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
