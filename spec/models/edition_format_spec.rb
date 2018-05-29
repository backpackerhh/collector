require 'rails_helper'

RSpec.describe EditionFormat, type: :model do
  it { is_expected.to belong_to :edition }
  it { is_expected.to belong_to :format }

  it { is_expected.to validate_presence_of :number_of_discs }
  it { is_expected.to validate_presence_of :format_id }
  it { is_expected.to validate_presence_of :edition_id }

  context 'validates uniqueness of :format_id within the scope of :edition_id' do
    let(:edition) { create(:edition) }
    let(:dvd)     { create(:format, name: 'DVD') }

    it 'not including any error when record is not persisted' do
      edition_format = described_class.new

      edition_format.valid?

      expect(edition_format.errors[:format_id]).to_not include 'has already been taken'
    end

    it 'not including any error when edition does not have formats associated' do
      edition.formats << create(:edition_format, format: dvd)

      edition.formats.first.valid?

      expect(edition.formats.first.errors[:format_id]).to_not include 'has already been taken'
    end

    it 'not including any error when same format has been marked for destruction' do
      edition.formats << create(:edition_format, format: dvd)
      edition.formats << build(:edition_format, format: dvd)

      edition.formats.first.mark_for_destruction
      edition.formats.last.valid?

      expect(edition.formats.last.errors[:format_id]).to_not include 'has already been taken'
    end

    it 'including error when same format has already been associated to edition' do
      edition.formats << create(:edition_format, format: dvd)
      edition.formats << build(:edition_format, format: dvd)

      edition.formats.last.valid?

      expect(edition.formats.last.errors[:format_id]).to include 'has already been taken'
    end
  end

  it { is_expected.to delegate_method(:name).to :format }
end
