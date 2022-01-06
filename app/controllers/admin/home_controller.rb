class Admin::HomeController < Admin::BaseController
  def index
    @vouchers = Voucher.order(created_at: :desc).limit(20)
    @q = Client.ransack(params[:q])
    @searched = !params[:q].nil?
    @searched_term = params[:q]&.values&.first
    @clients = @q.result(distinct: true)

    if @swap
      @change_swap = params["change_swap"]
      @vouchers_remaining_today = RoomSupply.vouchers_remaining_today(@swap)
      @num_vouchers_remaining_today = RoomSupply.num_vouchers_remaining_today(@swap)
      @supply = RoomSupply.by_hotel(@swap)
      @hotel_map = Hotel.all.pluck(:id, :name).to_h
    end
  end
end
