class AddSwapIdToIntakesAndShortIntakes < ActiveRecord::Migration[6.0]
  def change
    add_reference :intakes, :swap, null: false, foreign_key: true
    add_reference :short_intakes, :swap, null: false, foreign_key: true
  end
end
