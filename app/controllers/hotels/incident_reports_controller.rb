class Hotels::IncidentReportsController < Hotels::BaseController
  def create
    @incident_report = IncidentReport.new(incident_report_params)
    @incident_report.reporter_id = current_user.id

    if !@incident_report.save
      return redirect_back(
        error: "An error has occurred. Please try again.",
        fallback_location: root_path
      )
    end

    redirect_back(info: "New report created.", fallback_location: root_path)
  end

  private

  def incident_report_params
    params.require(:incident_report).permit(:occurred_at, :description, :client_id)
  end
end
