class AddShortIntakeIdToVouchers < ActiveRecord::Migration[6.1]
  def change
    add_column :vouchers, :short_intake_id, :integer
  end
end
