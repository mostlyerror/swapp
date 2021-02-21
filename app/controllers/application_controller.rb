class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_swap_current

  def set_swap_current
    @swap = Swap.current
  end
end
