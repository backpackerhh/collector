require 'rails_helper'

RSpec.describe FormatForm do
  subject(:format_form) { described_class.new(format) }

  let(:format) { Format.new }

  describe '.model_name' do
    it 'returns all kinds of naming-related information' do
      expect(format_form.class.model_name.name).to eq('Format')
    end
  end

  describe '#submit(params)' do
    let(:valid_params) do
      {
        name: 'DVD'
      }
    end

    let(:invalid_params) do
      {}
    end

    it 'preloads its own fields with given params' do
      format_form.submit(valid_params)

      expect(format_form.name).to eq('DVD')
    end

    context 'with invalid params' do
      it 'promotes errors to form fields' do
        format_form.submit(invalid_params)

        expect(format_form.errors[:name]).to include "can't be blank"
      end

      it 'does not create a new format' do
        expect { format_form.submit(invalid_params) }.to_not change { Format.count }
      end

      it 'returns false' do
        expect(format_form.submit(invalid_params)).to be_falsey
      end
    end

    context 'with valid params' do
      it 'creates a new format' do
        expect { format_form.submit(valid_params) }.to change { Format.count }.from(0).to 1
      end

      it 'returns true' do
        expect(format_form.submit(valid_params)).to be_truthy
      end
    end
  end
end
