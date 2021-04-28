class Hotels::IncidentReportsController < Hotels::BaseController
    def create
        @incident_report = IncidentReport.new(incident_report_params)
        @incident_report.reporter_id = current_user.id

        if !@incident_report.save
          puts 'poop'
          # handle some errors tho...
        end

        redirect_to hotels_vouchers_path(params[:voucher_id])
      end

  private
  def incident_report_params
    params.require(:incident_report).permit(:occurred_at, :description, :client_id)
  end
end