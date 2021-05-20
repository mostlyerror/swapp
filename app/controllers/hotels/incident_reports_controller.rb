class Hotels::IncidentReportsController < Hotels::BaseController
    def create
        @incident_report = IncidentReport.new(incident_report_params)
<<<<<<< HEAD
    
        @incident_report.client_id = params[:id]
        @incident_report.reporter_id = current_user.id
    
        if @incident_report.save
          redirect_to hotels_show_client_path(id: params[:id])
        end
=======
        @incident_report.reporter_id = current_user.id

        if !@incident_report.save
          return redirect_back(
            error: "An error has occurred. Please try again.",
            fallback_location: root_path
          )
        end

        redirect_back(info: "New report created.", fallback_location: root_path)
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
      end

  private
  def incident_report_params
<<<<<<< HEAD
    params.require(:incident_report).permit(:occurred_at, :description)
=======
    params.require(:incident_report).permit(:occurred_at, :description, :client_id)
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
  end
end