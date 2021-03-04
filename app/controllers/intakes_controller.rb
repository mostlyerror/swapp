class IntakesController < ApplicationController
  before_action :hydrate_form, only: %i[ new create ]

  def new
    @intake = Intake.new
    @client = Client.new
    @voucher = Voucher.new
  end

  def create
    @intake = Intake.new(intake_params.except(:voucher))
    @intake.user = current_user
    @intake.why_not_shelter = intake_params[:why_not_shelter].filter_map {|r| r == "0" ? nil : r }

    client_params = intake_params[:client_attributes]
    @client = Client.new(client_params)
    @client.race = client_params[:race].filter_map {|r| r == "0" ? nil : r }

    @motel = Motel.find(intake_params[:voucher][:motel_id])
    @check_in = intake_params[:voucher][:check_in]
    @check_out = intake_params[:voucher][:check_out]

    @intake.client = @client
    if !@intake.save
      return render :new
    end

    if @voucher = Voucher.create(
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
    params.require(:intake).permit(
      :homelessness_first_time,
      :episodes_last_three_years_fewer_than_four_times,
      :where_did_you_sleep_last_night, 
      {why_not_shelter: []},
      :armed_forces,
      :active_duty, 
      :substance_abuse, 
      :chronic_health_condition,
      :mental_health_condition, 
      :mental_health_disability,
      :physical_disability, 
      :developmental_disability,
      :fleeing_domestic_violence, 
      :bus_pass, 
      :king_soopers_card,
      :how_long_this_time,
      :total_how_long_shelters_or_streets,
      :are_you_working,
      :num_adults_in_household,
      :num_children_in_household,
      :last_permanent_residence_county,
      client_attributes: [:first_name, :last_name, :date_of_birth, :gender, {race: []}, :ethnicity, :phone_number, :email],
      voucher: [:check_in, :check_out, :motel_id],
    )
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
