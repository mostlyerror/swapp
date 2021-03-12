class AddIntakeStartAndIntakeEndToSwaps < ActiveRecord::Migration[6.0]
  def change
    add_column :swaps, :intake_start_date, :date
    add_column :swaps, :intake_end_date, :date
  end
end
