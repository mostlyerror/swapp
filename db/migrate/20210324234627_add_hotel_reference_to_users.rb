class AddHotelReferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :hotel, foreign_key: true
  end
end
