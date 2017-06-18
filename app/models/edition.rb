class Edition < ApplicationRecord
  belongs_to :distributor

  validates :name, :distributor_id, :country_code, :release_date, presence: true

  delegate :name, to: :distributor, prefix: true
end
