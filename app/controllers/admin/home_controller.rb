class Admin::HomeController < Admin::BaseController
  def index
    @current = SwapPeriod.current
  end
end
