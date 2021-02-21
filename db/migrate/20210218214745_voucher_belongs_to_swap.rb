class VoucherBelongsToSwap < ActiveRecord::Migration[6.0]
  def change
    add_reference :vouchers, :swap, references: :swaps, index: true
    add_foreign_key :vouchers, :swaps, column: :swap_id
  end
end
