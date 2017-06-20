class Region < ApplicationRecord
  belongs_to :format

  validates :name, :format_id, presence: true

  delegate :name, to: :format, prefix: true
end
