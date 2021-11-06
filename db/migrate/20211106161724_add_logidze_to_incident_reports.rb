class AddLogidzeToIncidentReports < ActiveRecord::Migration[6.0]
  def change
    add_column :incident_reports, :log_data, :jsonb

    reversible do |dir|
      dir.up do
        create_trigger :logidze_on_incident_reports, on: :incident_reports
      end

      dir.down do
        execute "DROP TRIGGER IF EXISTS logidze_on_incident_reports on incident_reports;"
      end
    end

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE incident_reports as t
          SET log_data = logidze_snapshot(to_jsonb(t), 'updated_at');
        SQL
      end
    end
  end
end
