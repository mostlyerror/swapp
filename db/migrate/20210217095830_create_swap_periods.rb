class CreateSwaps < ActiveRecord::Migration[6.0]
  def change
    create_table :swap_periods do |t|
      t.date :start_date, null: false
      t.date :end_date
      t.timestamps
    end
  end
end
