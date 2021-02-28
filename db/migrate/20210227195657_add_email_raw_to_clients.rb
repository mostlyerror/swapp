class AddEmailRawToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :email_raw, :string
  end
end
