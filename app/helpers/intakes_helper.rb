# == Schema Information
# Schema version: 20211117041844
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
module IntakesHelper
  def to_htmlfor(key)
    key.gsub("/", "")
    .gsub(/[^A-Za-z0-9\s]/i, '')
    .parameterize
    .underscore
  end

  def to_radio_htmlfor(key, choice)
    [key, choice].map {|i| i.to_s.parameterize.underscore }.join("_")
  end
end
