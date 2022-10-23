class Admin::HotelsController < Admin::BaseController
  def index
    respond_to do |format|
      format.json do
        render json: Hotel.all
      end

      format.csv do
        ts = Time.zone.now.strftime("%Y%m%dT%H%M")
        send_data Hotel.to_csv, filename: "hotels-#{ts}.csv"
      end
    end
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
