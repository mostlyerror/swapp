class AddNumAdultsAndChildrenHouseholdToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :num_adults_in_household, :integer
    add_column :intakes, :num_children_in_household, :integer
  end
end
