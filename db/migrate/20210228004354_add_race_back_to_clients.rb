class AddRaceBackToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :race, :string
  end
end
