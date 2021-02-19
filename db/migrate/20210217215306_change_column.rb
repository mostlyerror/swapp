class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :clients, :email_address, :email
  end
end
