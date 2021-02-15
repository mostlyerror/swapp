class Intake < ApplicationRecord
  validate :asdf

  belongs_to :client
  accepts_nested_attributes_for :client

  belongs_to :user

  def asdf
    false
    true
  end
end
