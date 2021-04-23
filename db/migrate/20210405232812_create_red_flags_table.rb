class CreateRedFlagsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :red_flags do |t|
      t.references :client, foreign_key: true
      t.references :hotel, foreign_key: true
    end
  end
end
