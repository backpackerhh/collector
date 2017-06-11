require 'rails_helper'

RSpec.describe DistributorForm do
  subject(:distributor_form) { described_class.new(distributor) }

  let(:distributor) { Distributor.new }

  describe '.model_name' do
    it 'returns all kinds of naming-related information' do
      expect(distributor_form.class.model_name.name).to eq('Distributor')
    end
  end

  describe '#submit(params)' do
    let(:valid_params) do
      {
        name: 'Warner Bros.'
      }
    end

    let(:invalid_params) do
      {}
    end

    it 'preloads its own fields with given params' do
      distributor_form.submit(valid_params)

      expect(distributor_form.name).to eq('Warner Bros.')
    end

    context 'with invalid params' do
      it 'promotes errors to form fields' do
        distributor_form.submit(invalid_params)

        expect(distributor_form.errors[:name]).to include "can't be blank"
      end

      it 'does not create a new distributor' do
        expect { distributor_form.submit(invalid_params) }.to_not change { Distributor.count }
      end

      it 'returns false' do
        expect(distributor_form.submit(invalid_params)).to be_falsey
      end
    end

    context 'with valid params' do
      it 'creates a new distributor' do
        expect { distributor_form.submit(valid_params) }.to change { Distributor.count }.from(0).to 1
      end

      it 'returns true' do
        expect(distributor_form.submit(valid_params)).to be_truthy
      end
    end
  end
end
