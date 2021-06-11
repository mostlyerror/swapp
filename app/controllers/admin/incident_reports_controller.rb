class Admin::IncidentReportsController < Admin::BaseController
  skip_before_action :verify_authenticity_token

  def create
    IncidentReport.transaction do
      client = Client.find(params[:id])
      hotel = Hotel.find(params[:hotel_id])

      @incident_report = IncidentReport.new(
        client: client,
        hotel_id: hotel.id,
        occurred_at: params[:date],
        description: params[:description],
        red_flag: params[:red_flag],
        reporter_id: current_user.id
      )

      if !@incident_report.save
        return redirect_back(
          error: "An error has occurred. Please try again.",
          fallback_location: root_path
        )
      end

      if params[:red_flag]
        client.ban_at!(hotel)
      end
    end

    redirect_back(info: "New report created.", fallback_location: root_path)
  end
end
