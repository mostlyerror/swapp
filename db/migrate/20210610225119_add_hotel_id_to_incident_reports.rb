class AddHotelIdToIncidentReports < ActiveRecord::Migration[6.0]
  def change
    add_column :incident_reports, :hotel_id, :integer
    add_column :incident_reports, :red_flag, :boolean, default: false
  end
end
