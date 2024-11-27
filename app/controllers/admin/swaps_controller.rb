class Admin::SwapsController < Admin::BaseController
  skip_before_action :verify_authenticity_token
  add_flash_types :info, :error

  def create
    stay_start = params["stayDates"]["from"]
    stay_end = params["stayDates"]["to"]
    intake_dates = params["intakeDates"].map(&:to_date)

    swap = Swap.new(
      start_date: stay_start,
      end_date: stay_end,
      intake_dates: intake_dates
    )

    if swap.save
      render json: swap, status: :created
    else
      render json: {
        errors: swap.errors.as_json(full_messages: true)
      }, status: :unprocessable_entity
    end
  end

  def update
    swap = Swap.find(params[:id])

    # true if the end date is being extended
    extend_vouchers = swap.end_date.before?(Date.parse(params["stayDates"]["to"]))
    
    swap.start_date = params["stayDates"]["from"]
    swap.end_date = params["stayDates"]["to"]
    swap.intake_dates = params["intakeDates"].map(&:to_date)

    if swap.update!(extend_vouchers)
      render json: swap, status: :created
    else
      render json: {
        errors: swap.errors.as_json(full_messages: true)
      }, status: :unprocessable_entity
    end
  end

  def update_room_supply
    supply_params = params.require(:voucher_supply).permit!

    Swap.transaction do
      swap = Swap.find(params[:id])
      swap.availabilities.destroy_all
      supply_params
      .reject { |_, v| v.blank? }
      .each do |(hotel_id, vacant)|
        swap.availabilities.create!(
          hotel_id: hotel_id,
          date: Date.current, # this should come from the page.. cause what if you open the page before midnight, then submit afterwards...?
          vacant: vacant
        )
      end
    end

    redirect_to admin_home_path
  end

  # I believe this function is not used, remove this?
  def edit_intake_dates
    swap = Swap.current
    Swap.transaction do
      intake_dates = params[:intake_dates].sort

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
