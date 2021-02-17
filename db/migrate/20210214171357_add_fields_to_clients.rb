class AddFieldsToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :race, :string
    add_column :clients, :ethnicity, :string
    add_column :clients, :email, :string
    add_column :clients, :phone_number, :string
  end
end
