class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_swap_current

  def set_swap_current
    @swap = Swap.current
    if @swap
      @vouchers_remaining_today = RoomSupply.vouchers_remaining_today(@swap)
      @num_vouchers_remaining_today = RoomSupply.num_vouchers_remaining_today(@swap)
      @supply = RoomSupply.by_motel(@swap)
      @motel_map = Motel.all.pluck(:id, :name).to_h
    end
  end
end
