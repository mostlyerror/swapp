class AddPetsToShortIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :short_intakes, :pets, :string
  end
end
