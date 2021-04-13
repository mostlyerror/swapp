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
end
