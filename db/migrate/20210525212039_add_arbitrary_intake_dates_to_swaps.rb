class AddArbitraryIntakeDatesToSwaps < ActiveRecord::Migration[6.0]
  def change
    add_column :swaps, :intake_dates, :date, array: true, default: []
  end
end
