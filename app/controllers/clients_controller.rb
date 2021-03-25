class ClientsController < ApplicationController
  def index
    if current_user.hotel_user?
      redirect_to hotels_home_path
    end

    @q = Client.ransack(params[:q])
    @searched = !params[:q].nil?
    @searched_term = params[:q]&.values&.first
    @clients = @q.result(distinct: true)
  end

  def show
    if current_user.hotel_user?
      redirect_to hotels_home_path
    end

    @client = Client.find(params[:id])
    @existing_voucher = @swap&.vouchers&.find_by(client: @client)
  end
end
