class RenameVoucherStartDateAndEndDate < ActiveRecord::Migration[6.0]
  def change
    rename_column :vouchers, :start_date, :check_in
    rename_column :vouchers, :end_date, :check_out
  end
end
