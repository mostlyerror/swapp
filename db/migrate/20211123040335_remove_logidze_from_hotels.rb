class RemoveLogidzeFromHotels < ActiveRecord::Migration[6.0]
  def up
    remove_column :hotels, :log_data
    execute "DROP TRIGGER IF EXISTS logidze_on_hotels on hotels;"
  end

  def down
    add_column :hotels, :log_data, :jsonb
    create_trigger :logidze_on_hotels, on: :hotels
    execute <<~SQL
          UPDATE hotels as t
          SET log_data = logidze_snapshot(to_jsonb(t), 'updated_at');
    SQL
  end
end
