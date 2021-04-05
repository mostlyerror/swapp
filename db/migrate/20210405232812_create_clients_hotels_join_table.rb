class CreateClientsHotelsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :clients, :hotels do |t|
      t.index :client_id
      t.index :hotel_id
      t.boolean :red_flagged
    end
  end
end
