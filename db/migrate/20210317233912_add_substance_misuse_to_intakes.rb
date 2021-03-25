class AddSubstanceMisuseToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :substance_misuse, :string
  end
end
