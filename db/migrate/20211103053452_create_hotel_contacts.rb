class CreateHotelContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string "first_name", null: false
      t.string "last_name", null: false
      t.string "phone", null: true
      t.string "email", null: true
      t.string "preferred_contact_method", null: true
      t.timestamps
    end

    create_table :hotels_contacts do |t|
      t.belongs_to :hotel
      t.belongs_to :contact
      t.timestamps 
      t.index ["hotel_id", "contact_id"], name: "index_hotels_contacts_on_hotel_id_and_contact_id", unique: true
    end
  end
end
