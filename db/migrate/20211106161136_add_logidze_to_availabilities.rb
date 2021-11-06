class AddLogidzeToAvailabilities < ActiveRecord::Migration[6.0]
  def change
    add_column :availabilities, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_availabilities, on: :availabilities
      end

      dir.down do
        execute "DROP TRIGGER IF EXISTS logidze_on_availabilities on availabilities;"
      end
    end

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE availabilities as t
          SET log_data = logidze_snapshot(to_jsonb(t), 'updated_at');
        SQL
      end
    end
  end
end
