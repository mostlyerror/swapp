FactoryBot.define do
  factory :intake do
    is_first_time = [true, false].sample
    homelessness_first_time { is_first_time }
    have_you_ever_experienced_homelessness_before { !is_first_time }
<<<<<<< HEAD
    homelessness_date_began { Faker::Date.backward(days: rand(10 * 360)) }
=======
    homelessness_date_began { FFaker::Time.between(10.years.ago, 1.years.ago).strftime('%Y') }
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
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
      income_source_ssdi{ (rand(10) * 100) }
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
