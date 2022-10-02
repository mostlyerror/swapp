# == Schema Information
# Schema version: 20220924214711
#
# Table name: incident_reports
#
#  id          :bigint           not null, primary key
#  description :text
#  occurred_at :datetime
#  red_flag    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :bigint           not null, indexed
#  hotel_id    :integer
#  reporter_id :bigint           indexed
#
# Indexes
#
#  index_incident_reports_on_client_id    (client_id)
#  index_incident_reports_on_reporter_id  (reporter_id)
#
# Foreign Keys
#
#  fk_rails_052937fe11  (reporter_id => users.id)
#  fk_rails_75542209ab  (client_id => clients.id)
#
class IncidentReport < ApplicationRecord
  belongs_to :client
  belongs_to :hotel
  belongs_to :reporter, class_name: "User"
end
