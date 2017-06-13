class Distributor < ApplicationRecord
  has_many :editions

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
