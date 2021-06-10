class Admin::IncidentReportsController < Admin::BaseController
  skip_before_action :verify_authenticity_token

  #   create_table "incident_reports", force: :cascade do |t|
  #   t.bigint "client_id", null: false
  #   t.text "description"
  #   t.datetime "occurred_at"
  #   t.datetime "created_at", precision: 6, null: false
  #   t.datetime "updated_at", precision: 6, null: false
  #   t.bigint "reporter_id"
  # hotel_id
  #   t.index ["client_id"], name: "index_incident_reports_on_client_id"
  #   t.index ["reporter_id"], name: "index_incident_reports_on_reporter_id"
  # end

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
  # private

  # def incident_report_params
  #   params.require(:incident_report).permit(:occurred_at, :description, :client_id)
  # end
end