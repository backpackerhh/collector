require 'rails_helper'

RSpec.describe PackagingForm do
  subject(:packaging_form) { described_class.new(packaging) }

  let(:packaging) { Packaging.new }

  describe '.model_name' do
    it 'returns all kinds of naming-related information' do
      expect(packaging_form.class.model_name.name).to eq('Packaging')
    end
  end

  describe '#submit(params)' do
    let(:valid_params) do
      {
        name: 'Digipak'
      }
    end

    let(:invalid_params) do
      {}
    end

    it 'preloads its own fields with given params' do
      packaging_form.submit(valid_params)

      expect(packaging_form.name).to eq('Digipak')
    end

    context 'with invalid params' do
      it 'promotes errors to form fields' do
        packaging_form.submit(invalid_params)

        expect(packaging_form.errors[:name]).to include "can't be blank"
      end

      it 'does not create a new packaging' do
        expect { packaging_form.submit(invalid_params) }.to_not change { Packaging.count }
      end

      it 'returns false' do
        expect(packaging_form.submit(invalid_params)).to be_falsey
      end
    end

    context 'with valid params' do
      it 'creates a new packaging' do
        expect { packaging_form.submit(valid_params) }.to change { Packaging.count }.from(0).to 1
      end

      it 'returns true' do
        expect(packaging_form.submit(valid_params)).to be_truthy
      end
    end
  end
end
