class IntakesController < ApplicationController
  # before_action :set_client, only: %i[ show edit update destroy ]

  # GET /intakes/new
  def new
    @intake = Intake.new
    @client = Client.new
  end

  # POST /intakes or /intakes.json
  def create
    @intake = Intake.new(intake_params)
    @intake.user = current_user
    @client = Client.new(intake_params['client_attributes'])

    Intake.transaction do |t|
      if !@client.save
        @client.errors.full_messages.each do |message|
          @intake.errors[:client] << message
        end
        return render :new
      end

      if !@intake.save
        return render :new
      end

      @voucher = Voucher.create!(
        client: @client,
        user: current_user,
        motel: Motel.last,
        start_date: Date.tomorrow,
        end_date: Date.tomorrow + 3.days,
        number: "AH0001"
      )
      return redirect_to @voucher
    end

    redirect_to @intake
  end

  private

  def intake_params
    params.require(:intake).permit(
      survey: [
        "king_soopers_card", "bus_pass", "num_nights", "hotel",
        "homelessness_first_time", "homelessness_how_long_this_time",
        "homelessness_episodes_last_three_years",
        "homelessness_episodes_how_long", "how_long_living_in_this_community",
        "where_did_you_sleep_last_night", "why_not_shelter", "are_you_working",
        "armed_forces", "active_duty", "substance_abuse",
        "substance_abuse_impairment", "chronic_health_condition",
        "chronic_health_condition_impairment", "mental_health_disability",
        "mental_health_disability_impairment", "physical_disability",
        "physical_disability_impairment", "developmental_disability",
        "developmental_disability_impairment", "fleeing_domestic_violence",
        "num_adults_household", "num_children_household",
        "last_permanent_residence_city_and_state",
        "last_permanent_residence_county"],
        client_attributes: [
          ["first_name", "last_name", "date_of_birth(2i)", "date_of_birth(3i)",
           "date_of_birth(1i)", "gender", "race", "ethnicity", "phone_number",
           "email_address"]
        ])
  end
end
