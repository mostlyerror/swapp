class LandingController < ApplicationController
  def index
    @swap = Swap.current
    if @swap
      @motel_map = Motel.all.pluck(:id, :name).to_h
      @supply = RoomSupply.by_motel(@swap).to_h
    end
  end
end
