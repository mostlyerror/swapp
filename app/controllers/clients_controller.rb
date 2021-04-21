class ClientsController < ApplicationController
  def index
    @q = Client.ransack(params[:q])
    @searched = !params[:q].nil?
    @searched_term = params[:q]&.values&.first
    @clients = @q.result(distinct: true)
  end

  def search
    q = params[:q].downcase
    clients = Client.includes(:incident_reports)
      .where("first_name ILIKE ? or last_name ILIKE ?", "%#{q}%", "%#{q}%").limit(10)
    @results = clients.map do |c| 
      attrs = c.slice(:id, :name, :date_of_birth)
      attrs.merge(red_flag: c.incident_reports.any?)
    end
    render json: @results
  end

  def show
    @client = Client.find(params[:id])
    @existing_voucher = @swap&.vouchers&.find_by(client: @client)
  end

  def create
    client_params = params.permit(:first_name, :last_name, :date_of_birth)
    if client_params['date_of_birth'].blank?
      client_params['date_of_birth'] = '1600-01-01'
    end

    if client = Client.create(client_params)
      return render json: client
    end

    render json: client.errors
  end
end
