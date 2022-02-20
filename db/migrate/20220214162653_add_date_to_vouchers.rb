class AddDateToVouchers < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :date, :date
  end
end
