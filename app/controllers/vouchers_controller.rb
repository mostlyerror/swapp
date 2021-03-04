class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[ show created ]

  def new
    @client = Client.find(params[:client_id])

    if @swap
      @short_intake = ShortIntake.new(client: @client, user: current_user)
      @existing_voucher = @swap.vouchers.find_by(client: @client)
      @voucher = Voucher.new(client: @client)
      supply = RoomSupply.vouchers_remaining_today(@swap)
      @disabled = []
      @motels = Motel.all.reduce({}) do |memo, motel|
        name = "#{motel.name} (#{supply[motel.id]})"
        if supply[motel.id].to_i <= 0
          @disabled << motel.id
        end
        memo.merge(Hash[name, motel.id])
      end
    end
  end

  def create
    @client = Client.find(voucher_params[:client][:id])
    @motels = Motel.all

    short_intake_params = voucher_params[:short_intake]
    @short_intake = ShrotIntake.new(short_intake_params)
    @short_intake.why_not_shelter = short-intake_params[:why_not_shelter].reject {|r| r == "0" }
    @short_intake.user = current_user

    @voucher = Voucher.new(
      swap: @swap,
      client: @client,
      user: current_user,
      motel_id: voucher_params[:motel_id],
      check_in: voucher_params[:check_in],
      check_out: voucher_params[:check_out],
    )

    if !@voucher.save
      # client has already received a voucher for the current swap period?
      if @voucher.errors[:client_id].include? "has already been taken"
        @existing_voucher = @swap.vouchers.find_by(client_id: @voucher.client_id)
      end
      return render :new
    end

    redirect_to action: :created, id: @voucher.id
  end

  def created
  end

  def show
  end

  private
    def voucher_params
      params.require(:voucher).permit(
        :check_in, 
        :check_out, 
        :motel_id, 
        :num_adults_in_household, 
        :num_children_in_household,
        client: [
          :id,
          :phone_number,
          :email
        ],
        short_intake: [
          :where_did_you_sleep_last_night,
          :what_city_did_you_sleep_in_last_night, 
          {why_not_shelter: []},
          :num_adults_in_household, 
          :num_children_in_household,
          :bus_pass,
          :king_soopers_card,
        ],
      )
    end

    def set_voucher
      @voucher = Voucher.find(params[:id])
    end
end
