class RenameSwapPeriodsToSwap < ActiveRecord::Migration[6.0]
  def change
    rename_table :swap_periods, :swaps
  end
end
