require 'rails_helper'

RSpec.describe FormatsDashboard, type: :dashboard do
  describe '#formats' do
    it 'returns expected records ordered by name' do
      create(:format, name: 'VHS')
      create(:format, name: 'DVD')
      create(:format, name: 'Blu-Ray')

      dashboard = described_class.new

      expect(dashboard.formats.pluck(:name)).to eq(['Blu-Ray', 'DVD', 'VHS'])
    end
  end
end
