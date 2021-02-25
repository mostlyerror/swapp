class AddPetFriendlyToMotels < ActiveRecord::Migration[6.0]
  def change
    add_column :motels, :pet_friendly, :boolean
  end
end
