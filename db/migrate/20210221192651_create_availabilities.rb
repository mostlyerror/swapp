class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.references :motel, null: false, foreign_key: true
      t.references :swap, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :rooms
      t.timestamps
    end
  end
end
