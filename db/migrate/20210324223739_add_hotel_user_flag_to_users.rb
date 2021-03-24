class AddHotelUserFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hotel_user, :boolean
  end
end
