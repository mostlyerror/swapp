class AddIncomeSourceToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :income_source, :string
  end
end
