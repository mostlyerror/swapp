class LandingController < ApplicationController
  def index
    if current_user.hotel_user?
      redirect_to hotels_home_path
    end
  end
end
