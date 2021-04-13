class Admin::RedFlagsController < Admin::BaseController
    add_flash_types :info, :error, :warning

    def edit_red_flag
        # make form send param like this:
        # hotel_ids: [1,2,3]
        client = Client.find(params[:id])
        RedFlag.transaction do 
            # client = Client.find(params[:id])

            RedFlag.where(client: client).destroy_all

            red_flag_attrs = params[:client][:hotel_ids].map do |hotel_id|
                {client_id: client.id, hotel_id: hotel_id}
            end


            if RedFlag.create(red_flag_attrs)
                redirect_to hotels_show_client_path(client), info: "Update successful!"
            end
        end
    end
end