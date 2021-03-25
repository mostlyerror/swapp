class AddHomelessnessEpisodesLastThreeYearsToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :homelessness_episodes_last_three_years, :string
  end
end
