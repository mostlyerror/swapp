class Admin::SwapsController < Admin::BaseController
  add_flash_types :info, :error

  def extend
    swap = Swap.find(params[:id])
    if swap.extend!(params['days'])
      return redirect_to admin_home_path
    else
      swap.errors.add(:extend, "Couldn't extend Swap period")
      return redirect_to admin_home_path
    end
  end

  def update_room_supply
    supply_params = params.require(:voucher_supply).permit!

    Swap.transaction do
      swap = Swap.find(params[:id])
      swap.availabilities.destroy_all
      supply_params
      .reject {|_, v| v.blank? }
      .each do |(hotel_id, vacant)|
        swap.availabilities.create!(
          hotel_id: hotel_id,
          date: Date.current, # this should come from the page.. cause what if you open the page before midnight, then submit afterwards...?
          vacant: vacant
        )
      end
    end

    return redirect_to admin_home_path
  end

  def edit_intake_dates
    swap = Swap.current
    Swap.transaction do 
      intake_dates = params[:intake_dates].sort()
     
      if swap.update(intake_dates: intake_dates)
        return redirect_back(
          info: "Dates successfully saved.",
          fallback_location: root_path
        )
      end

      redirect_back(
        error: "An error has occurred. Please try again.",
        fallback_location: root_path
      )
    end
  end
end