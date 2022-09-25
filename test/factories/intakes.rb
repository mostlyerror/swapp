# == Schema Information
# Schema version: 20220924214711
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
FactoryBot.define do
  factory :intake do
    household_tanf { [true, false].sample }
    have_you_ever_experienced_homelessness_before { [true, false].sample }
    homelessness_date_began { FFaker::Time.between(10.years.ago, 1.year.ago) }
    homelessness_how_long_this_time { Intake::HOMELESSNESS_HOW_LONG_THIS_TIME.choices.sample }
    homelessness_episodes_last_three_years { Intake::HOMELESSNESS_EPISODES_LAST_THREE_YEARS.choices.sample }
    homelessness_total_last_three_years { Intake::HOMELESSNESS_TOTAL_LAST_THREE_YEARS.choices.sample }
    health_insurance { Intake::HEALTH_INSURANCE.choices.sample }
    are_you_working { Intake::ARE_YOU_WORKING.choices.sample }

    non_cash_benefits { ["No"] }
    trait :with_non_cash_benefits do
      non_cash_benefits do
        choices = Intake::NON_CASH_BENEFITS.choices
        no_choice = choices.shift
        choices.size.times.map { choices.sample }.uniq
      end
    end

    income_source_any { false }
    trait :with_income do
      income_source_any { true }
      income_source_earned_income { (rand(10) * 100) }
      income_source_ssdi { (rand(10) * 100) }
      income_source_ssi { (rand(10) * 100) }
      income_source_unemployment_insurance { (rand(10) * 100) }
      income_source_tanf { (rand(10) * 100) }
      income_source_child_support { (rand(10) * 100) }
      income_source_retirement { (rand(10) * 100) }
      income_source_alimony { (rand(10) * 100) }
      income_source_veteran_service_compensation { (rand(10) * 100) }
      income_source_general_assistance { (rand(10) * 100) }
    end

    active_duty { [true, false].sample }
    substance_misuse { Intake::SUBSTANCE_MISUSE.choices.sample }
    chronic_health_condition { [true, false].sample }
    mental_health_disability { [true, false].sample }
    physical_disability { [true, false].sample }
    developmental_disability { [true, false].sample }
    fleeing_domestic_violence { [true, false].sample }
    last_permanent_residence_county { "Adams" }
  end
end
