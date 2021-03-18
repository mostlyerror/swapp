class IntakesController < ApplicationController
  before_action :hydrate_form, only: %i[ new create ]

  def new
    @intake = Intake.new
    @client = Client.new
    @voucher = Voucher.new
  end

  def create
    @intake = Intake.new(intake_params.except(:voucher))

    client_params = intake_params[:client_attributes]
    @client = Client.new(client_params)
    @client.race = client_params[:race].reject {|r| r == "0" }

    @intake.client = @client
    @intake.user = current_user
    if !@intake.save
      return render :new
    end

    redirect_to new_voucher_path(client_id: @client.id, intake_id: @intake.id)
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
      :how_long_this_time,
      :total_how_long_shelters_or_streets,
      :are_you_working,
      :last_permanent_residence_county,
      client_attributes: [:first_name, :last_name, :date_of_birth, :gender, {race: []}, :ethnicity, :phone_number, :email, :veteran],
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
