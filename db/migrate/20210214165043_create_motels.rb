class CreateMotels < ActiveRecord::Migration[6.0]
  def change
    create_table :motels do |t|
      t.string :name, null: false
      t.json :address
      t.string :phone

      t.timestamps
    end
  end
end
