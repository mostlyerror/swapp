class AddVoidedAtToVouchers < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :voided_at, :datetime, null: true
    add_reference :vouchers, :voided_by, foreign_key: { to_table: :users }
  end
end
