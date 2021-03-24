class AddHotelUserFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hotel_user, :boolean, null: false, default: false
  end
end
