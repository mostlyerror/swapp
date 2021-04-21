class AddGuestIdsToVouchers < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :guest_ids, :integer, array: true, default: []
  end
end
