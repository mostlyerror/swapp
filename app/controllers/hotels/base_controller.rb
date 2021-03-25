class Hotels::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action do 
    if !current_user.hotel_user?
      redirect_to new_user_session_path
    end
  end
end