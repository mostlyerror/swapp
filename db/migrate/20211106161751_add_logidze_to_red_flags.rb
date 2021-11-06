class AddLogidzeToRedFlags < ActiveRecord::Migration[6.0]
  def change
    add_column :red_flags, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_red_flags, on: :red_flags
      end

      dir.down do
        execute "DROP TRIGGER IF EXISTS logidze_on_red_flags on red_flags;"
      end
    end

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE red_flags as t
          SET log_data = logidze_snapshot(to_jsonb(t), 'updated_at');
        SQL
      end
    end
  end
end
