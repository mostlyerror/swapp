class ChangeClientsRaceToJsonbField < ActiveRecord::Migration[6.0]
  def change
    change_column :clients, :race, :jsonb, default: [], using: 'race::jsonb'
  end
end
