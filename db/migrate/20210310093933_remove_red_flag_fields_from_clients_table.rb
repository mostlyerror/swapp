class RemoveRedFlagFieldsFromClientsTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :clients, :red_flag
    remove_column :clients, :red_flag_reason
  end
end
