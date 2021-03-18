class AddHealthInsuranceToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :health_insurance, :string
  end
end
