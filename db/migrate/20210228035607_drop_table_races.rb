class DropTableRaces < ActiveRecord::Migration[6.0]
  def change
    drop_table :races
  end
end
