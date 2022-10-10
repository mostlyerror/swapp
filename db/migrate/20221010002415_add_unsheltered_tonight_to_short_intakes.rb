class AddUnshelteredTonightToShortIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :short_intakes, :unsheltered_tonight, :boolean
  end
end
