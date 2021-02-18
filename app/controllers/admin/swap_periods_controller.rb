class Admin::SwapPeriodsController < Admin::BaseController
  def extend
    puts "========"
    puts params
    puts swap_period_params
    puts "========"

    swap = SwapPeriod.find(params[:id])

    redirect_to admin_home_path
  end
end