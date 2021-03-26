class AddIntakeUserFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :intake_user, :boolean, null: false, default: false
  end
end
