require 'rails_helper'

RSpec.describe DistributorsDashboard, type: :dashboard do
  describe '#distributors' do
    it 'returns expected records ordered by name' do
      create(:distributor, name: 'Universal')
      create(:distributor, name: '20th Century Fox')
      create(:distributor, name: 'Disney')

      dashboard = described_class.new

      expect(dashboard.distributors.pluck(:name)).to eq(['20th Century Fox', 'Disney', 'Universal'])
    end
  end
end
