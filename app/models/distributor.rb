class Distributor < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
