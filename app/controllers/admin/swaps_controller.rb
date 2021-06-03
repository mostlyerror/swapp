class Admin::SwapsController < Admin::BaseController
  skip_before_action :verify_authenticity_token

  def create
    stay_start = params['stayDates']['from']
    stay_end = params['stayDates']['to']
    intake_dates = params['intakeDates'].map(&:to_date)

    swap = Swap.new(
      start_date: stay_start,
      end_date: stay_end,
      # intake_dates: intake_dates # TODO: pull in changes from intake dates branch so this can work
      # created_by: current_user   # created by?
    )

    if swap.save
      return render json: swap, status: :created
    end
  end

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
end