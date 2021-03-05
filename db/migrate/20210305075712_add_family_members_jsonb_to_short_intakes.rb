class AddFamilyMembersJsonbToShortIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :short_intakes, :family_members, :jsonb, default: {}, using: 'family_members::jsonb'
  end
end
