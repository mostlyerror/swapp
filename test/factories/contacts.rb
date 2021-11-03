# == Schema Information
# Schema version: 20211103053452
#
# Table name: contacts
#
#  id                       :bigint           not null, primary key
#  email                    :string
#  first_name               :string           not null
#  last_name                :string           not null
#  phone                    :string
#  preferred_contact_method :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
FactoryBot.define do
  factory :contact do
  end
end
