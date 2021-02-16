class AllowNullVoucherNumbersOnCreate < ActiveRecord::Migration[6.0]
  def change
    change_column :vouchers, :number, :string, :null => true
  end
end
