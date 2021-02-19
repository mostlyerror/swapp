class Admin::SwapPeriodsController < Admin::BaseController
  def extend
    swap = SwapPeriod.find(params[:id])
    swap.extend(params['days'])
    if swap.save
      return redirect_to admin_home_path
    else
      swap.errors.add(:extend, "Couldn't extend SwapPeriod")
      reuturn redirect_to admin_home_path
    end
  end
end