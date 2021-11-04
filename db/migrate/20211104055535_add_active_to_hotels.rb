class AddActiveToHotels < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :active, :boolean, default: true
  end
end
