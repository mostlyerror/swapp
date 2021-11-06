class AddLogidzeToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_contacts, on: :contacts
      end

      dir.down do
        execute "DROP TRIGGER IF EXISTS logidze_on_contacts on contacts;"
      end
    end

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE contacts as t
          SET log_data = logidze_snapshot(to_jsonb(t), 'updated_at');
        SQL
      end
    end
  end
end
