class AddHouseholdCompositionChangedToShortIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :short_intakes, :household_composition_changed, :boolean
  end
end
