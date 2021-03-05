class MigrateIntakeSurveyFieldsFromJsonbToColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :intakes, :survey

    add_column :intakes, :homelessness_first_time, :boolean
    add_column :intakes, :how_long_this_time, :string
    add_column :intakes, :episodes_last_three_years_fewer_than_four_times, :boolean
    add_column :intakes, :total_how_long_shelters_or_streets, :string
    add_column :intakes, :where_did_you_sleep_last_night, :string
    add_column :intakes, :why_not_shelter, :string, array: true, default: []
    add_column :intakes, :are_you_working, :boolean
    add_column :intakes, :armed_forces, :boolean
    add_column :intakes, :active_duty, :boolean
    add_column :intakes, :substance_abuse, :boolean
    add_column :intakes, :chronic_health_condition, :boolean
    add_column :intakes, :mental_health_condition, :boolean
    add_column :intakes, :mental_health_disability, :boolean
    add_column :intakes, :physical_disability, :boolean
    add_column :intakes, :developmental_disability, :boolean
    add_column :intakes, :fleeing_domestic_violence, :boolean
    add_column :intakes, :last_permanent_residence_county, :string
    add_column :intakes, :king_soopers_card, :boolean
    add_column :intakes, :bus_pass, :boolean
  end
end
