class CreateIncidentReports < ActiveRecord::Migration[6.0]
  def change
    create_table :incident_reports do |t|
      t.references :client, null: false, foreign_key: true
      t.text :description
      t.datetime :occurred_at, null: false
      t.timestamps
    end
  end
end
