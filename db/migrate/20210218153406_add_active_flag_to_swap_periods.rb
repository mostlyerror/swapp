class AddActiveFlagToSwaps < ActiveRecord::Migration[6.0]
  def change
    add_column :swaps, :active, :boolean, null: false, default: false
  end
end
