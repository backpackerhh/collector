class Packaging < ApplicationRecord
  has_many :edition_packagings
  has_many :editions, through: :edition_packagings

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
