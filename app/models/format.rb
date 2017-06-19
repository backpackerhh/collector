class Format < ApplicationRecord
  has_many :regions

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
