class RelaxNotNullConstraintOnIncidentReportsOccurredAt < ActiveRecord::Migration[6.0]
  def change
    change_column :incident_reports, :occurred_at, :datetime, null: true
  end
end
