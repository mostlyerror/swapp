class AddVehicleAndIdentificationQuestionsToShortIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :short_intakes, :vehicle, :boolean
    add_column :short_intakes, :identification, :string
  end
end
