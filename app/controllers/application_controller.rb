class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_swap_current

  def set_swap_current
    @hotel_map = Hotel.all.reduce({}) do |map, hotel|
      map.merge(Hash[hotel.id, hotel])
    end

    if @swap = Swap.current
      @vouchers_remaining_today = RoomSupply.vouchers_remaining_today(@swap)
      @num_vouchers_remaining_today = RoomSupply.num_vouchers_remaining_today(@swap)
      @supply = RoomSupply.by_hotel(@swap)
    end
  end
end
