class Edition < ApplicationRecord
  belongs_to :distributor

  delegate :name, to: :distributor, prefix: true
end
