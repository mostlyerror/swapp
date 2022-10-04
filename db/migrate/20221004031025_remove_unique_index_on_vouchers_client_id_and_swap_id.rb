class RemoveUniqueIndexOnVouchersClientIdAndSwapId < ActiveRecord::Migration[6.0]
  def change
    remove_index :vouchers, [:client_id, :swap_id]
  end
end
