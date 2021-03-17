class RemoveSubstanceAbuseFromIntakes < ActiveRecord::Migration[6.0]
  def change
    remove_column :intakes, :substance_abuse
  end
end
