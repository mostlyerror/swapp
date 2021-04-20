class Admin::RedFlagsController < Admin::BaseController
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
end