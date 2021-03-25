class AddHotelUserFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :motel_user, :boolean, null: false, default: false
  end
end
