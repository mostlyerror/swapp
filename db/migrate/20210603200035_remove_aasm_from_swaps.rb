class RemoveAasmFromSwaps < ActiveRecord::Migration[6.0]
  def change
    remove_column :swaps, :aasm_state
  end
end
