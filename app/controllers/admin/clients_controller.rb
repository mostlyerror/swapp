class Admin::ClientsController < Admin::BaseController
  def show
    # @swap = Swap.current
    # @vouchers = Voucher.order(created_at: :desc).limit(20)
    # @hotel_map = Hotel.all.pluck(:id, :name).to_h
    # @flagged_clients = Client.where(id: Client.ids).joins(:red_flags).uniq

    # if @swap
    #   @vouchers_remaining_today = RoomSupply.vouchers_remaining_today(@swap)
    #   @num_vouchers_remaining_today = RoomSupply.num_vouchers_remaining_today(@swap)
    #   @supply = RoomSupply.by_hotel(@swap)
    # end
  end
end
