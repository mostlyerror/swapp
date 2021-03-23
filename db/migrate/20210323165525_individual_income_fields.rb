class IndividualIncomeFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :intakes, :income_source
    remove_column :intakes, :income_total_monthly

    add_column :intakes, :income_source_earned_income, :integer
    add_column :intakes, :income_source_ssdi, :integer
    add_column :intakes, :income_source_ssi, :integer
    add_column :intakes, :income_source_unemployment_insurance, :integer
    add_column :intakes, :income_source_tanf, :integer
    add_column :intakes, :income_source_child_support, :integer
    add_column :intakes, :income_source_retirement, :integer
    add_column :intakes, :income_source_alimony, :integer
    add_column :intakes, :income_source_veteran_service_compensation, :integer
    add_column :intakes, :income_source_general_assistance, :integer
  end
end
