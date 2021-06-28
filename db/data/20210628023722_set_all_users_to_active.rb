class SetAllUsersToActive < ActiveRecord::Migration[6.0]
  def up
    User.all.each do |user|
      if user.active.nil?
        user.update(active: true)
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
