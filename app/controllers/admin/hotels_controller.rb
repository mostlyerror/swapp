class Admin::HotelsController < Admin::BaseController
  around_action :use_logidze_responsible, only: %i[import]

  def index
    respond_to do |format|
      format.csv do
        ts = Time.now.strftime("%Y%m%dT%H%M")
        send_data Hotel.to_csv, filename: "hotels-#{ts}.csv"
      end
    end
  end

  def importer
  end

  def import
    Hotel.import(params[:file])
    redirect_to admin_home_path, notice: "Hotel data updated."
  end
end
