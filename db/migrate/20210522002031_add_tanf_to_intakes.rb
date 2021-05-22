class AddTanfToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :household_tanf, :boolean
  end
end
