class CreateShortIntakes < ActiveRecord::Migration[6.0]
  def change
    remove_column :intakes, :where_did_you_sleep_last_night
    remove_column :intakes, :what_city_did_you_sleep_in_last_night
    remove_column :intakes, :why_not_shelter

    create_table :short_intakes do |t| t.string :where_did_you_sleep_last_night
      t.string :what_city_did_you_sleep_in_last_night
      t.string :why_not_shelter, default: [], array: true
      t.timestamps
    end

    add_column :vouchers, :num_adults_in_household, :integer
    add_column :vouchers, :num_children_in_household, :integer
  end
end
