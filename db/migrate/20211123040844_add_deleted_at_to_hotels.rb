class AddDeletedAtToHotels < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :deleted_at, :datetime, null: true, index: true
  end
end
