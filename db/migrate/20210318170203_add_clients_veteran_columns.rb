class AddClientsVeteranColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :veteran, :boolean
    add_column :clients, :veteran_military_branch, :string
    add_column :clients, :veteran_separation_year, :string
    add_column :clients, :veteran_discharge_status, :string
  end
end
