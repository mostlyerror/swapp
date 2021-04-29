class Admin::RedFlagsController < Admin::BaseController
  add_flash_types :info, :error

  def edit_red_flag
    client_id = params[:id]
    RedFlag.transaction do 
      RedFlag.where(client_id: client_id).destroy_all

      red_flag_attrs = params[:client][:hotel_ids].map do |hotel_id|
        {client_id: client_id, hotel_id: hotel_id}
      end

      redirect_back(
        error: "An error has occurred. Please try again.",
        fallback_location: root_path
      )
    end
  end
end