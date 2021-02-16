class Intake < ApplicationRecord
  belongs_to :client
  accepts_nested_attributes_for :client

  belongs_to :user
end
