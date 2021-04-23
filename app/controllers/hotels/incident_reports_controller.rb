class Hotels::IncidentReportsController < Hotels::BaseController
    def create
        @incident_report = IncidentReport.new(incident_report_params)
    
        @incident_report.client_id = params[:id]
        @incident_report.reporter_id = current_user.id
    
        if @incident_report.save
          redirect_to hotels_show_client_path(id: params[:id])
        end
      end

  private
  def incident_report_params
    params.require(:incident_report).permit(:occurred_at, :description)
  end
end