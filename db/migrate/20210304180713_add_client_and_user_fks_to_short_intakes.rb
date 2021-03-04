class AddClientAndUserFksToShortIntakes < ActiveRecord::Migration[6.0]
  def change
    add_reference :short_intakes, :client, null: false, foreign_key: true
    add_reference :short_intakes, :user, null: false, foreign_key: true
  end
end
