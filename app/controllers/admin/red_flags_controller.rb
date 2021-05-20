class Admin::RedFlagsController < Admin::BaseController
<<<<<<< HEAD
    add_flash_types :info, :error

    def edit_red_flag
        RedFlag.transaction do 
            RedFlag.where(client_id: params[:id]).destroy_all

            red_flag_attrs = params[:client][:hotel_ids].map do |hotel_id|
                {client_id: params[:id], hotel_id: hotel_id}
            end


            if RedFlag.create(red_flag_attrs)
                redirect_to hotels_show_client_path(params[:id]), info: "Update successful!"
            else
                redirect_to hotels_show_client_path(params[:id]), error: "An error has occurred. Please try again."
            end
        end
    end
=======
  add_flash_types :info, :error

  def edit_red_flag
    client_id = params[:id]
    RedFlag.transaction do 
      RedFlag.where(client_id: client_id).destroy_all

      red_flag_attrs = params[:client][:hotel_ids].map do |hotel_id|
        {client_id: client_id, hotel_id: hotel_id}
      end

      if RedFlag.create(red_flag_attrs)
        return redirect_back(
          info: "Flags updated successfully.",
          fallback_location: root_path
        )
      end

      redirect_back(
        error: "An error has occurred. Please try again.",
        fallback_location: root_path
      )
    end
  end
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
end