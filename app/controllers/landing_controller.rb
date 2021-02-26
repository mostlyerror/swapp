class LandingController < ApplicationController
  before_action :authenticate_user!
  def index
    @motel_map = Motel.all.pluck(:id, :name).to_h
    @swap = Swap.current
    @supply = RoomSupply.by_motel(@swap).to_h
  end
end
