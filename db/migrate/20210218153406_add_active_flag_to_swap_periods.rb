class AddActiveFlagToSwapPeriods < ActiveRecord::Migration[6.0]
  def change
    add_column :swap_periods, :active, :boolean, null: false, default: false
  end
end
