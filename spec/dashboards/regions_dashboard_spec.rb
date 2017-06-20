require 'rails_helper'

RSpec.describe RegionsDashboard, type: :dashboard do
  describe '#regions' do
    it 'returns expected records ordered by name' do
      create(:region, name: 'B')
      create(:region, name: 'A')
      create(:region, name: 'C')

      dashboard = described_class.new

      expect(dashboard.regions.pluck(:name)).to eq(['A', 'B', 'C'])
    end
  end
end
