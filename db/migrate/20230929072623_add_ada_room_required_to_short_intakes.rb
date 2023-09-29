class AddAdaRoomRequiredToShortIntakes < ActiveRecord::Migration[6.1]
  def change
    add_column :short_intakes, :ada_room_required, :boolean
  end
end
