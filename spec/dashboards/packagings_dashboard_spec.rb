require 'rails_helper'

RSpec.describe PackagingsDashboard, type: :dashboard do
  describe '#packagings' do
    it 'returns expected records ordered by name' do
      create(:packaging, name: 'Digipak')
      create(:packaging, name: 'Digibook')
      create(:packaging, name: 'Steelbook')

      dashboard = described_class.new

      expect(dashboard.packagings.pluck(:name)).to eq(['Digibook', 'Digipak', 'Steelbook'])
    end
  end
end
