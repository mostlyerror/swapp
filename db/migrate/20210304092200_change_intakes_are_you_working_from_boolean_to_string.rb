class ChangeIntakesAreYouWorkingFromBooleanToString < ActiveRecord::Migration[6.0]
  def change
    change_column :intakes, :are_you_working, :string
  end
end
