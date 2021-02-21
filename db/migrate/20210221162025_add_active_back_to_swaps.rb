class AddActiveBackToSwaps < ActiveRecord::Migration[6.0]
  def change
    add_column :swaps, :active, :boolean, required: true, default: false
  end
end
