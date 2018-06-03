class EditionPackaging < ApplicationRecord
  belongs_to :edition
  belongs_to :packaging

  validates :packaging_id, :edition_id, presence: true
  validates :packaging_id, uniqueness: { scope: :edition_id }, unless: :same_packaging_is_marked_for_destruction?

  delegate :name, to: :packaging

  private

  def same_packaging_is_marked_for_destruction?
    return if edition.nil?

    same_packaging = edition.packagings.find { |f| f.packaging_id == packaging_id }

    return if same_packaging.nil?

    same_packaging.marked_for_destruction?
  end
end
