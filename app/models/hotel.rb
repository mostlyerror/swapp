# == Schema Information
# Schema version: 20211104055535
#
# Table name: hotels
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  address      :json
#  name         :string           not null
#  pet_friendly :boolean          default(FALSE)
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Hotel < ApplicationRecord
  has_many :availabilities
  has_many :vouchers
  has_many :hotel_users, class_name: 'HotelUser', table_name: :hotels_users
  has_many :users, through: :hotel_users
  has_many :hotels_contacts, class_name: "HotelContact", table_name: :hotels_contacts
  has_many :contacts, through: :hotels_contacts
  has_many :red_flags, class_name: 'RedFlag', table_name: :red_flags
  has_many :clients, through: :red_flags

  validates_presence_of :name

  default_scope { where(active: true) }

  def street_address
    address['street']
  end

  def address_second
    "#{address['city']}, #{address['state']} #{address['zip']}"
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << column_names
      all.each do |hotel|
        row = column_names.map  do |col| 
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
        row.delete(:created_at)
        row.delete(:updated_at)

        if id = row.delete("id").last
          Hotel.find(id).update!(row.to_h)
        else
          Hotel.create!(row.to_h)
        end
      end
    end
  end
end
