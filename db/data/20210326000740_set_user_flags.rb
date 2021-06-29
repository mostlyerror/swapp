class SetUserFlags < ActiveRecord::Migration[6.0]
  def up
    hotel_users = User.where("email ILIKE ?", "%frontdesk%")
    hotel_users.update_all(hotel_user: true, intake_user: false, admin_user: false)

    intake_users = User.where.not("email ILIKE ?", "%frontdesk%")
    intake_users.update_all(intake_user: true, hotel_user: false)
  end
end

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
