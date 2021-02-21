class ChangeClientsDateOfBirthToDateType < ActiveRecord::Migration[6.0]
  def change
    change_column :clients, :date_of_birth, :date
  end
end
