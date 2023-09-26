class AddWaiverAndParticipantAgremeentToShortIntakes < ActiveRecord::Migration[
  6.1
]
  def change
    add_column :short_intakes, :waiver_and_participant_agreement, :boolean
  end
end
