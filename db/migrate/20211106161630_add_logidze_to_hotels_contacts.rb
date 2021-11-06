class AddLogidzeToHotelsContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels_contacts, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_hotel_contacts, on: :hotels_contacts
      end

      dir.down do
        execute "DROP TRIGGER IF EXISTS logidze_on_hotel_contacts on hotels_contacts;"
      end
    end

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE hotels_contacts as t
          SET log_data = logidze_snapshot(to_jsonb(t), 'updated_at');
        SQL
      end
    end
  end
end
