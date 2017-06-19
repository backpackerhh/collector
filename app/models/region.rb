class Region < ApplicationRecord
  belongs_to :format

  delegate :name, to: :format, prefix: true
end
