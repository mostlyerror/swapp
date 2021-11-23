# == Schema Information
# Schema version: 20211123040336
#
# Table name: hotels
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  address      :jsonb
#  deleted_at   :datetime
#  name         :string           not null
#  pet_friendly :boolean          default(FALSE)
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Hotel < ApplicationRecord
  # include SoftDeletable
  has_logidze

  has_many :availabilities
  has_many :vouchers
  has_many :hotel_users, class_name: 'HotelUser', table_name: :hotels_users
  has_many :users, through: :hotel_users
  has_many :hotels_contacts, class_name: "HotelContact", table_name: :hotels_contacts
  has_many :contacts, through: :hotels_contacts
  has_many :red_flags, class_name: 'RedFlag', table_name: :red_flags
  has_many :clients, through: :red_flags

  validates_presence_of :name

  scope :active, ->() { where(active: true) }

  def street_address
    address['street']
  end

  def address_second
    "#{address['city']}, #{address['state']} #{address['zip']}"
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      ignore_columns = %w[log_data created_at updated_at]
      selected_columns = column_names - ignore_columns
      csv << selected_columns
      all.each do |hotel|
        row = selected_columns.map  do |col| 
          col == "address" ?
            hotel.send(col).to_json :
            hotel.send(col) 
        end
        csv << row
      end
    end
  end

  def self.import(file)
    ActiveRecord::Base.transaction do 
      CSV.foreach(file.path, headers: true) do |row|
        row["address"] = JSON.parse(row["address"]) if row["address"].present?

        if id = row.delete("id").last
          Hotel.find(id).update!(row.to_h)
        else
          Hotel.create!(row.to_h)
        end
      end
    end
  end
end
