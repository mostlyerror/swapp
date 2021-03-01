class RemoveRawFields < ActiveRecord::Migration[6.0]
  def change
  remove_column :clients, :email_raw
  remove_column :clients, :phone_number_raw
  end
end
