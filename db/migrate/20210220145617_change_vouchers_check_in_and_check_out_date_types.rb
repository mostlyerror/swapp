class ChangeVouchersCheckInAndCheckOutDateTypes < ActiveRecord::Migration[6.0]
  def change
    change_column :vouchers, :check_in, :date
    change_column :vouchers, :check_out, :date
  end
end
