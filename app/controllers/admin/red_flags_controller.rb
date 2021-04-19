class Admin::RedFlagsController < Admin::BaseController
    add_flash_types :info, :error, :warning

    def edit_red_flag
        RedFlag.transaction do 
            RedFlag.where(client_id: params[:id]).destroy_all

            red_flag_attrs = params[:client][:hotel_ids].map do |hotel_id|
                {client_id: params[:id], hotel_id: hotel_id}
            end


            if RedFlag.create(red_flag_attrs)
                redirect_to hotels_show_client_path(params[:id]), info: "Update successful!"
            end
        end
    end
end