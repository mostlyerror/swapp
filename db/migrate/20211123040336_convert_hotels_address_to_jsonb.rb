class ConvertHotelsAddressToJsonb < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :address_jsonb, :jsonb, default: '{}'
    Hotel.update_all('address_jsonb = address::jsonb')
    remove_column :hotels, :address
    rename_column :hotels, :address_jsonb, :address
  end
end
