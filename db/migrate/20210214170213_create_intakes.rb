class CreateIntakes < ActiveRecord::Migration[6.0]
  def change
    create_table :intakes do |t|
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.json :survey

      t.timestamps
    end
  end
end
