class AddAasmStateToSwaps < ActiveRecord::Migration[6.0]
  def change
    add_column :swaps, :aasm_state, :string
  end
end
