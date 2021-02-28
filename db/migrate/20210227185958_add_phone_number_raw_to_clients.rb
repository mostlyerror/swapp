class AddPhoneNumberRawToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :phone_number_raw, :string
  end
end
