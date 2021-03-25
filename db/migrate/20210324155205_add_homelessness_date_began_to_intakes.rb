class AddHomelessnessDateBeganToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :homelessness_date_began, :date
  end
end
