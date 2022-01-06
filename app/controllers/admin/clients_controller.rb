class Admin::ClientsController < Admin::BaseController
  def index
    @q = Client.ransack(params[:q])
    @searched = !params[:q].nil?
    @searched_term = params[:q]&.values&.first
    @clients = @q.result(distinct: true)
  end

  def search
    results = ClientSearch.search(params[:q]["first_name_or_last_name_cont"])
    render json: results
  end

  def show
    @client = Client.find(params[:id])
    @swap = Swap.current
    @hotels = Hotel.all
    @hotel_map = Hotel.all.pluck(:id, :name).to_h
    @incidents = @client
      .incident_reports.order(created_at: :desc)
      .map do |incident|
        {
          reportedBy: {
            firstName: incident.reporter.first_name,
            lastName: incident.reporter.last_name,
            email: incident.reporter.email
          },
          dateOfIncident: incident.occurred_at,
          description: incident.description
        }
      end

    @incident_report = IncidentReport.new
  end

  def update
    @client = Client.find(params[:id])
    client_params = params.require(:client).permit!

    if client_params["date_of_birth"].blank?
      client_params["date_of_birth"] = "1600-01-01"
    end

    client_params[:race] = client_params[:race].reject { |r| r == "0" }.sort

    if @client.update(client_params)
      return redirect_to @client
    end
    render :show
  end

  # POST /clients
  # guests form sends xhr request to this endpoint
  # new clients are normally created in conjunction with intakes in intakes#create
  def create
    client_params = params.require("client").permit(:first_name, :last_name, :date_of_birth)
    if client_params["date_of_birth"].blank?
      client_params["date_of_birth"] = "1600-01-01"
    end

    client = Client.new(client_params.merge(force_intake: true))
    if client.save
      return render json: client, status: :ok
    end

    render json: client.errors.full_messages, status: :unprocessable_entity
  end
end
