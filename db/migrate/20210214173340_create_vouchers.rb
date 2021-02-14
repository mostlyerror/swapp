class CreateVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers do |t|
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :intake, null: false, foreign_key: true
      t.references :motel, null: false, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :number, null: false

      t.timestamps
    end
  end
end
