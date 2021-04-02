class MoveFamilyMembersToClients < ActiveRecord::Migration[6.0]
  def change
    remove_column :short_intakes, :family_members, :jsonb
    add_column :clients, :family_members, :jsonb, default: {}, using: 'family_members::jsonb'
  end
end
