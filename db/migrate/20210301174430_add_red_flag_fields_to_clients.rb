class AddRedFlagFieldsToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :red_flag, :boolean
    add_column :clients, :red_flag_reason, :string
  end
end
