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
require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "contact can have 0 to many hotels" do
    c = create(:contact)
  end
end
