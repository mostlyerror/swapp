class AddVoucherFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :intake_user, :boolean
  end
end
