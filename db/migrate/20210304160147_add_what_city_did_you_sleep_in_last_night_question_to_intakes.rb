class AddWhatCityDidYouSleepInLastNightQuestionToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :what_city_did_you_sleep_in_last_night, :string
  end
end
