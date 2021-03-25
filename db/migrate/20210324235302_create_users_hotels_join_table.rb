class CreateUsersHotelsJoinTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :hotel_id, :integer

    create_join_table :users, :hotels do |t|
      t.index :user_id
      t.index :hotel_id
    end
  end
end
