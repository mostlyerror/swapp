class AddLatitudeLongitudeFieldsToMotels < ActiveRecord::Migration[6.0]
  def change
    add_column :motels, :lat, :decimal, {:precision=>10, :scale=>7}
    add_column :motels, :lng, :decimal, {:precision=>10, :scale=>7}
  end
end
