class RemoveIntakeStartAndIntakeEndDateFromSwaps < ActiveRecord::Migration[6.0]
  def change
    remove_column :swaps, :intake_start_date
    remove_column :swaps, :intake_end_date
  end
end
