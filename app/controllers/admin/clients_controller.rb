class Admin::ClientsController < Admin::BaseController
  def show
    @client = Client.find(params[:id])

    @swap = Swap.current

    @hotels = Hotel.all

    @hotel_map = Hotel.all.pluck(:id, :name).to_h
      
    @hotels = Hotel.all

    @flag_hotel_ids = @client.flagged_hotels.pluck(:id)

    @flagged_stamps = RedFlag.where(client: @client).pluck(:created_at)

    @incident_report = IncidentReport.new

    @incident_reports = @client.incident_reports.order(created_at: :desc).select do |ir| 
      current_user.admin_user? || current_user == ir.reporter
    end
  end
end
