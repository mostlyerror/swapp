class RemoveActiveFromSwaps < ActiveRecord::Migration[6.0]
  def change
    remove_column :swaps, :active
  end
end
