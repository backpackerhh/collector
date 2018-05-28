class Format < ApplicationRecord
  has_many :regions
  has_many :edition_formats
  has_many :editions, through: :edition_formats

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
