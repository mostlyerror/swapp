class Race < ApplicationRecord
  has_logidze
  validates :name, uniqueness: true

  has_and_belongs_to_many :clients
end
