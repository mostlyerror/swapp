class AddHmisIdToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :hmis_id, :string
  end
end
