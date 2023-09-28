class AddCountyEligibilityToIntakes < ActiveRecord::Migration[6.1]
  def change
    add_column :intakes, :county_eligibility, :string
  end
end
