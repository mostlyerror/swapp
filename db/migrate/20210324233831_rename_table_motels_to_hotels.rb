class RenameTableMotelsToHotels < ActiveRecord::Migration[6.0]
  def change
    rename_table :motels, :hotels
    rename_column :availabilities, :motel_id, :hotel_id
    rename_column :users, :motel_user, :hotel_user
    rename_column :vouchers, :motel_id, :hotel_id

  end
end
