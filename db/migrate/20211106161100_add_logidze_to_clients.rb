class AddLogidzeToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_clients, on: :clients
      end

      dir.down do
        execute "DROP TRIGGER IF EXISTS logidze_on_clients on clients;"
      end
    end

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE clients as t
          SET log_data = logidze_snapshot(to_jsonb(t), 'updated_at');
        SQL
      end
    end
  end
end
