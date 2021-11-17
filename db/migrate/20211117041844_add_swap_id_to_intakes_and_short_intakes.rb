class AddSwapIdToIntakesAndShortIntakes < ActiveRecord::Migration[6.0]
  def change
    add_reference :intakes, :swap, null: true, foreign_key: true
    # update swap_ids
    # set null false
    #
    add_reference :short_intakes, :swap, null: true, foreign_key: true
    # update swap_ids
    # set null false
  end
end
