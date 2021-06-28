class SetAllUsersToActive < ActiveRecord::Migration[6.0]
  def up
    User.all.each do |user|
      user.update(active: true)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
