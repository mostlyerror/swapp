class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.datetime :date_of_birth
      t.string :gender

      t.timestamps
    end
  end
end
