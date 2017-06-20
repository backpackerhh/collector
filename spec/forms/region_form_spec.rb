require 'rails_helper'

RSpec.describe RegionForm do
  subject(:region_form) { described_class.new(region) }

  let(:region) { Region.new }

  describe '.model_name' do
    it 'returns all kinds of naming-related information' do
      expect(region_form.class.model_name.name).to eq('Region')
    end
  end

  describe '#submit(params)' do
    let(:format) { create(:format, name: 'Blu-Ray') }

    let(:valid_params) do
      {
        name: 'B',
        format_id: format.id
      }
    end

    let(:invalid_params) do
      {}
    end

    it 'preloads its own fields with given params' do
      region_form.submit(valid_params)

      expect(region_form.name).to eq('B')
      expect(region_form.format_id).to eq(format.id)
    end

    context 'with invalid params' do
      it 'promotes errors to form fields' do
        region_form.submit(invalid_params)

        expect(region_form.errors[:name]).to include "can't be blank"
        expect(region_form.errors[:format_id]).to include "can't be blank"
      end

      it 'does not create a new region' do
        expect { region_form.submit(invalid_params) }.to_not change { Region.count }
      end

      it 'returns false' do
        expect(region_form.submit(invalid_params)).to be_falsey
      end
    end

    context 'with valid params' do
      it 'creates a new region' do
        expect { region_form.submit(valid_params) }.to change { Region.count }.from(0).to 1
      end

      it 'returns true' do
        expect(region_form.submit(valid_params)).to be_truthy
      end
    end
  end
end
