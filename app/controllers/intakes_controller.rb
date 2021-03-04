class IntakesController < ApplicationController
  before_action :hydrate_form, only: %i[ new create ]

  def new
    @intake = Intake.new
    @client = Client.new
    @voucher = Voucher.new
  end

  def create
    Intake.transaction do |t|
      @intake = Intake.new(intake_params)
      @intake.user = current_user

      client_params = intake_params['client_attributes']
      @client = Client.new(client_params)
      @client.race = client_params['race'].filter_map {|r| r == "0" ? nil : r }

      @motel = Motel.find(intake_params["survey"]["motel_id"])
      @check_in = intake_params["survey"]["check_in"]
      @check_out = intake_params["survey"]["check_out"]

      @intake.client = @client
      if !@intake.save
        return render :new
      end

      @voucher = Voucher.create!(
        client: @client,
        user: current_user,
        motel: @motel,
        check_in: @check_in,
        check_out: @check_out,
        swap: @swap
      )

      return redirect_to voucher_created_path(@voucher)
    end

    redirect_to @intake
  end

  private

  def intake_params
    params.require(:intake).permit!
  end

  def hydrate_form
    @disabled = []
    supply = RoomSupply.vouchers_remaining_today(@swap)
    @motels = Motel.all.reduce({}) do |memo, motel|
      name = "#{motel.name} (#{supply[motel.id]})"
      if supply[motel.id].to_i <= 0
        @disabled << motel.id
      end
      memo.merge(Hash[name, motel.id])
    end
  end
end
