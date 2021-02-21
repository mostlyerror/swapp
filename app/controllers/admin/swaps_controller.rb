class Admin::SwapsController < Admin::BaseController
  def extend
    swap = Swap.find(params[:id])
    if swap.extend!(params['days'])
      return redirect_to admin_home_path
    else
      swap.errors.add(:extend, "Couldn't extend Swap period")
      return redirect_to admin_home_path
    end
  end
end