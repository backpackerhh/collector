class EditionFormat < ApplicationRecord
  belongs_to :edition
  belongs_to :format

  validates :number_of_discs, :format_id, :edition_id, presence: true
  validates :format_id, uniqueness: { scope: :edition_id }, unless: :same_format_is_marked_for_destruction?

  delegate :name, to: :format

  private

  def same_format_is_marked_for_destruction?
    return if edition.nil?

    same_format = edition.formats.find { |f| f.format_id == format_id }

    return if same_format.nil?

    same_format.marked_for_destruction?
  end
end
