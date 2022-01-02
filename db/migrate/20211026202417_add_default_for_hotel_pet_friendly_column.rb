class AddDefaultForHotelPetFriendlyColumn < ActiveRecord::Migration[6.0]
  def up
    Hotel.with_deleted.where(pet_friendly: nil).update_all(pet_friendly: false)

    change_column :hotels, :pet_friendly, :boolean, default: false
  end

  def down
    change_column :hotels, :pet_friendly, :boolean, default: nil
  end
end
