class RenameAdminUserColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :admin, :admin_user
  end
end
