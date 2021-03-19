class AddIncomeTotalMonthlyToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :income_total_monthly, :integer
  end
end
