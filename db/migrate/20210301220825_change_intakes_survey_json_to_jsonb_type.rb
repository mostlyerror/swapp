class ChangeIntakesSurveyJsonToJsonbType < ActiveRecord::Migration[6.0]
  def change
    change_column :intakes, :survey, :jsonb, default: {}, using: 'survey::jsonb'
  end
end
