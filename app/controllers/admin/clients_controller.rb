class Admin::ClientsController < Admin::BaseController
  def show
    @client = Client.find(params[:id])
    @swap = Swap.current
    @hotels = Hotel.all
    @hotel_map = Hotel.all.pluck(:id, :name).to_h
    # @flagged_stamps = RedFlag.where(client: @client).pluck(:created_at)
    # @incident_report = IncidentReport.new
    @incidents = @client.incident_reports.order(created_at: :desc)
    @incident_report = IncidentReport.new
  end
end
