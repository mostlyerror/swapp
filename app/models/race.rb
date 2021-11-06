class Race < ApplicationRecord
  has_logidze
  validates_uniqueness_of :name

  has_and_belongs_to_many :clients
end
