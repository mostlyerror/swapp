# == Schema Information
# Schema version: 20211223223312
#
# Table name: intakes
#
#  id                                              :bigint           not null, primary key
#  active_duty                                     :boolean
#  are_you_working                                 :string
#  armed_forces                                    :boolean
#  chronic_health_condition                        :boolean
#  developmental_disability                        :boolean
#  episodes_last_three_years_fewer_than_four_times :boolean
#  fleeing_domestic_violence                       :boolean
#  have_you_ever_experienced_homelessness_before   :boolean
#  health_insurance                                :string
#  homelessness_date_began                         :date
#  homelessness_episodes_last_three_years          :string
#  homelessness_first_time                         :boolean
#  homelessness_how_long_this_time                 :string
#  homelessness_total_last_three_years             :string
#  household_tanf                                  :boolean
#  income_source_alimony                           :integer
#  income_source_any                               :boolean
#  income_source_child_support                     :integer
#  income_source_earned_income                     :integer
#  income_source_general_assistance                :integer
#  income_source_retirement                        :integer
#  income_source_ssdi                              :integer
#  income_source_ssi                               :integer
#  income_source_tanf                              :integer
#  income_source_unemployment_insurance            :integer
#  income_source_veteran_service_compensation      :integer
#  last_permanent_residence_county                 :string
#  mental_health_condition                         :boolean
#  mental_health_disability                        :boolean
#  non_cash_benefits                               :jsonb
#  physical_disability                             :boolean
#  substance_abuse                                 :boolean
#  substance_misuse                                :string
#  total_how_long_shelters_or_streets              :string
#  created_at                                      :datetime         not null
#  updated_at                                      :datetime         not null
#  client_id                                       :bigint           not null, indexed
#  swap_id                                         :bigint           indexed
#  user_id                                         :bigint           not null, indexed
#
# Indexes
#
#  index_intakes_on_client_id  (client_id)
#  index_intakes_on_swap_id    (swap_id)
#  index_intakes_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_3c0b295085  (client_id => clients.id)
#  fk_rails_5601279132  (user_id => users.id)
#  fk_rails_cc14202886  (swap_id => swaps.id)
#
class IntakesController < ApplicationController
  def new
    if params[:client_id].present?
      @client = Client.find(params[:client_id])
    else
      @client = Client.new
    end

    @intake = Intake.new
    @voucher = Voucher.new
  end

  def create
    client_params = intake_params[:client_attributes]

    if client_params[:client_id]
      @client = Client.find(client_params[:client_id])
    elsif client_params[:id].present?
      @client = Client.find(client_params[:id])
    else
      @client = Client.new
    end

    @client.assign_attributes(client_params.merge(
      veteran: !!client_params[:veteran],
      veteran_separation_year: client_params[:veteran_separation_year].presence,
      family_members: params.dig(:intake, :client_attributes, :family_members)&.permit!&.to_h || {},
      force_intake: false
    ))

    if !@client.save
      return render :new
    end

    @intake = Intake.new(intake_params.except(:voucher, :client_attributes).merge(
      swap_id: @swap.id,
      user_id: current_user.id,
      client_id: @client.id,
      household_tanf: !!intake_params[:household_tanf],
      have_you_ever_experienced_homelessness_before: !intake_params[:homelessness_first_time],
      non_cash_benefits: intake_params[:non_cash_benefits].reject {|r| r == "0" },
      income_source_any: !!intake_params[:income_source_any],
      active_duty: !!intake_params[:active_duty],
      chronic_health_condition: !!intake_params[:chronic_health_condition],
      mental_health_disability: !!intake_params[:mental_health_disability],
      physical_disability: !!intake_params[:physical_disability],
      developmental_disability: !!intake_params[:developmental_disability],
      fleeing_domestic_violence: !!intake_params[:fleeing_domestic_violence]
    ))

    if !@intake.save
      return render :new
    end

    redirect_to new_voucher_path(client_id: @client.id, intake_id: @intake.id)
  end

  private

  def intake_params
    params.require(:intake).permit(
      :homelessness_first_time,
      :homelessness_date_began,
      :homelessness_episodes_last_three_years,
      :where_did_you_sleep_last_night, 
      :household_tanf,
      {why_not_shelter: []},
      :armed_forces,
      :active_duty, 
      :substance_misuse, 
      :chronic_health_condition,
      :mental_health_disability,
      :physical_disability, 
      :developmental_disability,
      :fleeing_domestic_violence, 
      :homelessness_how_long_this_time,
      :total_how_long_shelters_or_streets,
      :are_you_working,
      :last_permanent_residence_county,
      :homelessness_total_last_three_years,
      :health_insurance,
      :income_source_any,
      :income_source_earned_income,
      :income_source_ssdi,
      :income_source_ssi,
      :income_source_unemployment_insurance,
      :income_source_tanf,
      :income_source_child_support,
      :income_source_retirement,
      :income_source_alimony,
      :income_source_veteran_service_compensation,
      :income_source_general_assistance,
      {non_cash_benefits: []},
      client_attributes: [
        :id,
        :first_name, 
        :last_name, 
        :date_of_birth, 
        :gender, 
        {race: []},
        :ethnicity,
        :phone_number,
        :email,
        :veteran,
        :veteran_military_branch,
        :veteran_separation_year,
        :veteran_discharge_status,
      ]
    )
  end
end
