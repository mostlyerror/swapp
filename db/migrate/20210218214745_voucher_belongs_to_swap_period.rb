class VoucherBelongsToSwapPeriod < ActiveRecord::Migration[6.0]
  def change
    add_reference :vouchers, :swap_period, references: :swap_periods, index: true
    add_foreign_key :vouchers, :swap_periods, column: :swap_period_id
  end
end
