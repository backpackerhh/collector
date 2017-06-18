require 'rails_helper'

RSpec.describe EditionForm do
  subject(:edition_form) { described_class.new(edition) }

  let(:edition) { Edition.new }

  describe '.model_name' do
    it 'returns all kinds of naming-related information' do
      expect(edition_form.class.model_name.name).to eq('Edition')
    end
  end

  describe '#submit(params)' do
    let(:paramount) { create(:distributor, name: 'Paramount') }

    let(:valid_params) do
      {
        name: 'The Godfather: 40th Anniversary Edition',
        distributor_id: paramount.id,
        country_code: 'IT',
        release_date: '2012-06-13'
      }
    end

    let(:invalid_params) do
      {}
    end

    it 'preloads its own fields with given params' do
      edition_form.submit(valid_params)

      expect(edition_form.name).to eq('The Godfather: 40th Anniversary Edition')
      expect(edition_form.distributor_id).to eq(paramount.id)
      expect(edition_form.country_code).to eq('IT')
      expect(edition_form.release_date.to_s).to eq('2012-06-13')
    end

    context 'with invalid params' do
      it 'promotes errors to form fields' do
        edition_form.submit(invalid_params)

        expect(edition_form.errors[:name]).to include "can't be blank"
        expect(edition_form.errors[:distributor_id]).to include "can't be blank"
        expect(edition_form.errors[:country_code]).to include "can't be blank"
        expect(edition_form.errors[:release_date]).to include "can't be blank"
      end

      it 'does not create a new edition' do
        expect { edition_form.submit(invalid_params) }.to_not change { Edition.count }
      end

      it 'returns false' do
        expect(edition_form.submit(invalid_params)).to be_falsey
      end
    end

    context 'with valid params' do
      it 'creates a new edition' do
        expect { edition_form.submit(valid_params) }.to change { Edition.count }.from(0).to 1
      end

      it 'returns true' do
        expect(edition_form.submit(valid_params)).to be_truthy
      end
    end
  end

  describe '#distributors' do
    it 'returns expected records ordered by name' do
      create(:distributor, name: 'Universal')
      create(:distributor, name: '20th Century Fox')
      create(:distributor, name: 'Disney')

      expect(edition_form.distributors.pluck(:name)).to eq(['20th Century Fox', 'Disney', 'Universal'])
    end
  end

  describe '#countries' do
    it 'returns codes for all priority countries' do
      expect(edition_form.countries).to match_array(['ES', 'GB', 'US', 'FR', 'DE', 'IT', 'JP', 'KR', 'CA', 'CN', 'CZ'])
    end
  end
end
