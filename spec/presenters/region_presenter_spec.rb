require 'rails_helper'

RSpec.describe RegionPresenter, type: :presenter do
  subject(:presenter) { described_class.new(region, mock_action_view) }

  let(:format) { create(:format, name: 'DVD') }
  let(:region) { create(:region, name: 'Free', format: format) }

  include_examples 'common methods for presenters'do
    let(:record) { region }
  end

  describe '#format' do
    it 'returns format name' do
      expect(presenter.format).to eq('DVD')
    end
  end
end
