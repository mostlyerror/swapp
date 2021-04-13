class ClientsController < ApplicationController
  def index
    @q = Client.ransack(params[:q])
    @searched = !params[:q].nil?
    @searched_term = params[:q]&.values&.first
    @clients = @q.result(distinct: true)
  end

  def search
    q = params[:q].downcase
    clients = Client.where("first_name ILIKE ? or last_name ILIKE ?", "%#{q}%", "%#{q}%").limit(5)
    @results = clients.map {|c| { id: c.id, name: c.name, date_of_birth: c.date_of_birth } }
    render json: @results
    # render json: {data: @results}
  end

  def show
    @client = Client.find(params[:id])
    @existing_voucher = @swap&.vouchers&.find_by(client: @client)
  end
end
