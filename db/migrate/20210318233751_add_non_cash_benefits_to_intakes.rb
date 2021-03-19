class AddNonCashBenefitsToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :non_cash_benefits, :boolean
  end
end
