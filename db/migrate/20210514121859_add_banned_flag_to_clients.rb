class AddBannedFlagToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :banned, :boolean, default: false
  end
end
