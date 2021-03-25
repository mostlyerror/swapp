class RenameHowLongColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :intakes, :how_long_this_time, :homelessness_how_long_this_time
  end
end
