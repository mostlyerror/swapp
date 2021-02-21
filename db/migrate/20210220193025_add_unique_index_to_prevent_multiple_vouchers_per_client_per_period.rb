class AddUniqueIndexToPreventMultipleVouchersPerClientPerPeriod < ActiveRecord::Migration[6.0]
  def change
    add_index :vouchers, [:client_id, :swap_id]
  end
end
