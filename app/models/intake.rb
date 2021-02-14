class Intake < ApplicationRecord
  validate :asdf

  belongs_to :client
  accepts_nested_attributes_for :client

  belongs_to :user

  def asdf
    errors[:base] << "dafuq this intake?!"
    false
  end
end
