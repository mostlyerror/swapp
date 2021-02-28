class CreateJoinTableClientRace < ActiveRecord::Migration[6.0]
  def change
    create_join_table :clients, :races do |t|
      t.index :client_id
      t.index :race_id
    end
  end
end
