class MigrateFamilyMembersToClients < ActiveRecord::Migration[6.0]
  def self.up
    add_column :clients, :family_members, :jsonb, default: {}, using: 'family_members::jsonb'
    remove_column :short_intakes, :family_members, :jsonb
  end

  def self.down
    add_column :short_intakes , :family_members, :jsonb, default: {}, using: 'family_members::jsonb'
    remove_column :clients, :family_members, :jsonb
  end
end
