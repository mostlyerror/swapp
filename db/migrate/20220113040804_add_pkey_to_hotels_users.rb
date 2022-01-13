class AddPkeyToHotelsUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels_users, :id, :primary_key
  end
end
