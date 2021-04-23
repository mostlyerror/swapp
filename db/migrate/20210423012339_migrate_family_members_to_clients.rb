class MigrateFamilyMembersToClients < ActiveRecord::Migration[6.0]
  def self.up
    add_column :clients, :family_members, :jsonb, default: {}, using: 'family_members::jsonb'
    execute "UPDATE clients c SET family_members = (SELECT family_members FROM short_intakes si where si.client_id = c.id);"
    remove_column :short_intakes, :family_members, :jsonb
  end

  def self.down
    add_column :short_intakes , :family_members, :jsonb, default: {}, using: 'family_members::jsonb'
    execute "UPDATE short_intakes si SET family_members = (SELECT family_members FROM clients c where si.client_id = c.id);"
    remove_column :clients, :family_members, :jsonb
  end
end
