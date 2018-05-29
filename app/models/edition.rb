class Edition < ApplicationRecord
  belongs_to :distributor
  has_many :formats, inverse_of: :edition, class_name: 'EditionFormat', dependent: :destroy
  accepts_nested_attributes_for :formats, allow_destroy: true

  validates :name, :distributor_id, :country_code, :release_date, presence: true
  validates :formats, presence: true, on: :update

  delegate :name, to: :distributor, prefix: true
end
