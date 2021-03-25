class RenameAdminUserColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :admin, :boolean, null: false, default: false
    rename_column :users, :admin, :admin_user
  end
end
