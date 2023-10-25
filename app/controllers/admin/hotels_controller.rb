class Admin::HotelsController < ApplicationController
  layout 'layouts/admin/admin'
  before_action :set_hotel, only: %i[show edit update destroy]

  # GET /hotels or /hotels.json
  def index
    @hotels = Hotel.all.order('active DESC', 'name')

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @hotels }
      format.csv do
        ts = Time.zone.now.strftime('%Y%m%dT%H%M')
        send_data Hotel.to_csv, filename: "hotels-#{ts}.csv"
      end
    end
  end

  # GET /hotels/1 or /hotels/1.json
  def show; end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit; end

  # POST /hotels or /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)

    respond_to do |format|
      if @hotel.save
        format.html do
          redirect_to admin_hotel_url(@hotel),
                      notice: 'Hotel was successfully created.'
        end
        format.json do
          render :show, status: :created, location: admin_hotel_url(@hotel)
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @hotel.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /hotels/1 or /hotels/1.json
  def update
    hotel_params['address'] = JSON.parse(hotel_params['address'])

    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html do
          redirect_to admin_hotel_url(@hotel),
                      notice: 'Hotel was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: admin_hotel_url(@hotel)
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @hotel.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /hotels/1 or /hotels/1.json
  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html do
        redirect_to admin_hotels_url,
                    notice: 'Hotel was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def hotel_params
    # params.fetch(:hotel, {})
    # params.permit!
    params.require(:hotel).permit!
  end
end
