class VouchersController < ApplicationController
  before_action :set_voucher, only: %i[show created]
  before_action :set_voucher_supply_for_hotel_dropdown, only: %i[new]

  def new
    @client = Client.find(params[:client_id])
    @voucher = Voucher.new(client: @client)
    @unsheltered_tonight = params[:unsheltered_tonight]

    if @swap
      @short_intake = ShortIntake.new(client: @client, user: current_user)
      @existing_voucher = @swap.vouchers.active.find_by(client: @client)
    end
  end

  def create
    Voucher.transaction do
      client_params = voucher_params[:client]
      @client = Client.find(client_params[:id])
      @voucher = Voucher.new(client: @client, swap: @swap, issuer: current_user)

      if !@client.update(
           phone_number: client_params[:phone_number],
           email: client_params[:email],
         )
        return render :new
      end

      short_intake_params = voucher_params[:short_intake]
      @short_intake = ShortIntake.new(short_intake_params)

      # Intake could not proceed to this point unless this was answered `true`.
      # For all intakes # prior to 10/2022, this was recorded on a separate,
      # paper "Homelessness # Verification Form"
      @short_intake.unsheltered_tonight = true
      @short_intake.why_not_shelter =
        short_intake_params[:why_not_shelter].reject { |r| r == '0' }
      @short_intake.client = @client
      @short_intake.user = current_user
      @short_intake.swap = @swap
      @short_intake.vehicle = !!short_intake_params[:vehicle]

      return render :new if !@short_intake.save

      @voucher.assign_attributes(
        hotel_id: voucher_params[:hotel_id],
        check_in: voucher_params[:check_in],
        check_out: voucher_params[:check_out],
        num_adults_in_household: voucher_params[:num_adults_in_household],
        num_children_in_household: voucher_params[:num_children_in_household],
        guest_ids: voucher_params[:guest_ids],
      )

      @voucher.validate

      # client has already received a voucher for the current swap period?
      if @voucher.errors[:client_id].include? 'has already been taken'
        @existing_voucher =
          @swap.vouchers.find_by(client_id: @voucher.client_id)
        return render :new
      end

      return render :new if !@voucher.save
    end

    redirect_to action: :created, id: @voucher.id
  end

  def created; end

  def send_voucher
    voucher = Voucher.find(params[:id])

    if params[:commit] == 'E-mail'
      VoucherMailer.with(voucher: voucher).voucher_email.deliver_now
    elsif params[:commit] == 'Text/SMS'
      VoucherTexter.send_sms(voucher, ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
    end
  end

  def show; end

  private

  def voucher_params
    params
      .require(:voucher)
      .permit(
        :check_in,
        :check_out,
        :hotel_id,
        :guests,
        guest_ids: [],
        client: %i[id phone_number email],
        short_intake: [
          :where_did_you_sleep_last_night,
          :what_city_did_you_sleep_in_last_night,
          { why_not_shelter: [] },
          :pets,
          :vehicle,
          :waiver_and_participant_agreement,
          :identification,
          :bus_pass,
          :king_soopers_card,
        ],
      )
  end

  def set_voucher
    @voucher = Voucher.find(params[:id])
  end

  def set_voucher_supply_for_hotel_dropdown
    @client = Client.find(params[:client_id] || voucher_params[:client][:id])
    if @swap
      supply = RoomSupply.vouchers_remaining_today(@swap)
      @disabled = []
      @client.flagged_hotels.map { |hotel| @disabled.push(hotel) }
      @hotels =
        Hotel
          .active
          .reduce({}) do |memo, hotel|
            name = "#{hotel.name} (#{supply[hotel.id]})"
            @disabled << hotel.id if supply[hotel.id].to_i <= 0
            memo.merge({ name => hotel.id })
          end
    end
  end
end
