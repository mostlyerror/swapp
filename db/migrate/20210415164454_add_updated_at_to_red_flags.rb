class AddUpdatedAtToRedFlags < ActiveRecord::Migration[6.0]
  def change
    add_timestamps(:red_flags)
  end
end
