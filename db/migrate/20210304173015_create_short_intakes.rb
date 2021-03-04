class CreateShortIntakes < ActiveRecord::Migration[6.0]
  def change
    remove_column :intakes, :where_did_you_sleep_last_night
    remove_column :intakes, :what_city_did_you_sleep_in_last_night
    remove_column :intakes, :why_not_shelter
    remove_column :intakes, :bus_pass
    remove_column :intakes, :king_soopers_card
    add_column :vouchers, :num_adults_in_household, :integer
    add_column :vouchers, :num_children_in_household, :integer

    create_table :short_intakes do |t| 
      t.string :where_did_you_sleep_last_night
      t.string :what_city_did_you_sleep_in_last_night
      t.string :why_not_shelter, default: [], array: true
      t.boolean :bus_pass
      t.boolean :king_soopers_card

      t.timestamps
    end

  end
end
