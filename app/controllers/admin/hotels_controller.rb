class Admin::HotelsController < Admin::BaseController
  def index
    respond_to do |format|
      format.json do
        render json: Hotel.with_deleted.all
      end

      format.csv do
        ts = Time.zone.now.strftime("%Y%m%dT%H%M")
        send_data Hotel.with_deletd.to_csv, filename: "hotels-#{ts}.csv"
      end
    end
  end

  # POST /admin/hotels
  # POST /admin/hotels.json
  def create
    address = {
      street: params["street_address"],
      city: params["city"],
      zip: params["zip"]
    }

    @hotel = Hotel.new(hotel_params.merge(address: address))

    if @hotel.save
      render json: @hotel, status: :created
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  def hotel_params
    params.require(:hotel).permit(%i[name phone street_address city zip])
  end

  def importer
  end

  # admin_hotels_manager GET    /admin/hotels/manager(.:format)
  def manager
  end

  def import
    Hotel.import(params[:file])
    redirect_to admin_home_path, notice: "Hotel data updated."
  end
end
