class AddActiveToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :active, :boolean, default: true
  end

  def down
    remove_column :users, :active
  end
end
