class Admin::SwapsController < Admin::BaseController
  def extend
    swap = Swap.find(params[:id])
    swap.extend(params['days'])
    if swap.save
      return redirect_to admin_home_path
    else
      swap.errors.add(:extend, "Couldn't extend Swap period")
      return redirect_to admin_home_path
    end
  end
end