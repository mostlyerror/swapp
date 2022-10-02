# == Schema Information
# Schema version: 20220924214711
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
FactoryBot.define do
  factory :contact do
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    phone { FFaker::PhoneNumber.phone_number }
    preferred_contact_method { %w[text email phone].sample }
    title { %w[front_desk general_manager].sample }
  end
end
