class AddReporterToIncidentReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :incident_reports, :reporter, references: :users, index: true
    add_foreign_key :incident_reports, :users, column: :reporter_id
  end
end
