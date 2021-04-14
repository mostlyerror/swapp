class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[ show created ]
  before_action :set_voucher_supply_for_hotel_dropdown, only: %i[ new create ]

  def new
    @client = Client.find(params[:client_id])
    @voucher = Voucher.new(client: @client)

    if @swap
      @previous_short_intakes = ShortIntake.where(client: @client)
      @short_intake = ShortIntake.new(client: @client, user: current_user)
      @existing_voucher = @swap.vouchers.find_by(client: @client)
    end
  end

  def create
    client_params = voucher_params[:client]
    @client = Client.find(client_params[:id])
    @voucher = Voucher.new(
      client: @client,
      swap: @swap,
      user: current_user
    )

    if !@client.update(
        phone_number: client_params[:phone_number],
        email: client_params[:email],
    )
      return render :new
    end

    short_intake_params = voucher_params[:short_intake]
    @short_intake = ShortIntake.new(short_intake_params)
    @short_intake.why_not_shelter = short_intake_params[:why_not_shelter].reject {|r| r == "0" }
    @short_intake.client = @client
    @short_intake.user = current_user

    @short_intake.household_composition_changed = short_intake_params[:household_composition_changed] == "No"
    if @short_intake.household_composition_changed
      @short_intake.family_members = {}
    end

    if !@short_intake.save
      return render :new
    end

    @voucher.assign_attributes(
      hotel_id: voucher_params[:hotel_id],
      check_in: voucher_params[:check_in],
      check_out: voucher_params[:check_out],
      num_adults_in_household: voucher_params[:num_adults_in_household],
      num_children_in_household: voucher_params[:num_children_in_household]
    )

    @voucher.validate
    # client has already received a voucher for the current swap period?
    if @voucher.errors[:client_id].include? "has already been taken"
      @existing_voucher = @swap.vouchers.find_by(client_id: @voucher.client_id)
      return render :new
    end

    if !@voucher.save
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
      :hotel_id, 
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
        :household_composition_changed,
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

  def set_voucher_supply_for_hotel_dropdown
    @client = Client.find(params[:client_id])
    flagged_hotels = @client.hotels.ids
    if @swap
      supply = RoomSupply.vouchers_remaining_today(@swap)
      @disabled = []
      flagged_hotels.map {|hotel| @disabled.push(hotel)}
      @hotels = Hotel.all.reduce({}) do |memo, hotel|
        name = "#{hotel.name} (#{supply[hotel.id]})"
        if supply[hotel.id].to_i <= 0
          @disabled << hotel.id
        end
        memo.merge(Hash[name, hotel.id])
      end
    end
  end
end
