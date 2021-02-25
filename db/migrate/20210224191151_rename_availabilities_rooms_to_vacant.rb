class RenameAvailabilitiesRoomsToVacant < ActiveRecord::Migration[6.0]
  def change
    rename_column :availabilities, :rooms, :vacant
  end
end
