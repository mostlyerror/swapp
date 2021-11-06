# == Schema Information
# Schema version: 20211103053452
#
# Table name: contacts
#
#  id                       :bigint           not null, primary key
#  email                    :string
#  first_name               :string           not null
#  last_name                :string
#  phone                    :string
#  preferred_contact_method :string
#  title                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class Contact < ApplicationRecord
  has_logidze
  has_many :hotels_contacts, class_name: "HotelContact", table_name: :hotels_contacts
  has_many :hotels, through: :hotels_contacts
end
