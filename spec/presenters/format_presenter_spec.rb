require 'rails_helper'

RSpec.describe FormatPresenter, type: :presenter do
  subject(:presenter) { described_class.new(format, mock_action_view) }

  let(:format) { create(:format, name: 'Blu-Ray') }

  include_examples 'common methods for presenters'do
    let(:record) { format }
  end

  describe '#regions' do
    it 'returns default text when format has no regions associated' do
      expect(presenter.regions).to eq('None')
    end

    it 'returns each region name, separated by comma' do
      create(:region, name: 'Free', format: format)
      create(:region, name: 'A', format: format)
      create(:region, name: 'B')

      expect(presenter.regions).to eq('Free, A')
    end
  end
end
