class AddIncomeTotalMonthlyToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :income_total_monthly, :jsonb, default: [], using: ':income_total_monthly::jsonb'
  end
end
