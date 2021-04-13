class ClientsController < ApplicationController
  def index
    @q = Client.ransack(params[:q])
    @searched = !params[:q].nil?
    @searched_term = params[:q]&.values&.first
    @clients = @q.result(distinct: true)
  end

  def show
    @client = Client.find(params[:id])
    @existing_voucher = @swap&.vouchers&.find_by(client: @client)
    @red_flagged = Client.where(id: @client).joins(:red_flags)
  end
end
