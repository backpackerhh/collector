require 'rails_helper'

RSpec.describe EditionDecorator, type: :decorator do
  subject(:decorator) { described_class.new(edition) }

  let(:edition) { Edition.new(country_code: 'ES') }

  describe '#to_model' do
    it 'returns the decorated object' do
      expect(decorator.to_model).to eq(edition)
    end
  end

  describe '#country' do
    it 'returns the name of the country according to its code' do
      expect(decorator.country).to eq('Spain')
    end
  end
end
