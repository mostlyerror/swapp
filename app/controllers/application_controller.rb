class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_swap_current

  def set_swap_current
    @hotel_map = Hotel.active.reduce({}) do |map, hotel|
      map.merge({hotel.id => hotel})
    end

    if @swap = Swap.current_or_upcoming
      @vouchers_remaining_today = RoomSupply.vouchers_remaining_today(@swap)
      @num_vouchers_remaining_today = RoomSupply.num_vouchers_remaining_today(@swap)
      @supply = RoomSupply.by_hotel(@swap)
      @num_active_vouchers = @swap.vouchers.active.size
    end
  end
end
