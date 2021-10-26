class AddDefaultForHotelPetFriendlyColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :hotels, :pet_friendly, :boolean, default: false
  end
end
