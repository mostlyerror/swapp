class AddNotesToVouchers < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :notes, :text
  end
end
