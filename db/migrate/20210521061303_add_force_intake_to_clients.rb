class AddForceIntakeToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :force_intake, :boolean, default: false
  end
end
