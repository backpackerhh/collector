require 'rails_helper'

RSpec.describe EditionPackaging, type: :model do
  it { is_expected.to belong_to :edition }
  it { is_expected.to belong_to :packaging }

  it { is_expected.to validate_presence_of :packaging_id }
  it { is_expected.to validate_presence_of :edition_id }

  context 'validates uniqueness of :packaging_id within the scope of :edition_id' do
    let(:edition) { create(:edition) }
    let(:digipak) { create(:packaging, name: 'Digipak') }

    it 'not including any error when record is not persisted' do
      edition_packaging = described_class.new

      edition_packaging.valid?

      expect(edition_packaging.errors[:packaging_id]).to_not include 'has already been taken'
    end

    it 'not including any error when edition does not have packagings associated' do
      edition.packagings << create(:edition_packaging, packaging: digipak)

      edition.packagings.first.valid?

      expect(edition.packagings.first.errors[:packaging_id]).to_not include 'has already been taken'
    end

    it 'not including any error when same packaging has been marked for destruction' do
      edition.packagings << create(:edition_packaging, packaging: digipak)
      edition.packagings << build(:edition_packaging, packaging: digipak)

      edition.packagings.first.mark_for_destruction
      edition.packagings.last.valid?

      expect(edition.packagings.last.errors[:packaging_id]).to_not include 'has already been taken'
    end

    it 'including error when same packaging has already been associated to edition' do
      edition.packagings << create(:edition_packaging, packaging: digipak)
      edition.packagings << build(:edition_packaging, packaging: digipak)

      edition.packagings.last.valid?

      expect(edition.packagings.last.errors[:packaging_id]).to include 'has already been taken'
    end
  end

  it { is_expected.to delegate_method(:name).to :packaging }
end
