class DropClientRaceJoinTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :clients_races
  end
end
