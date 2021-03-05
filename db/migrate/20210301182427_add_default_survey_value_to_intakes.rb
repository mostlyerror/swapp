class AddDefaultSurveyValueToIntakes < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:intakes, :survey, {})
  end
end
