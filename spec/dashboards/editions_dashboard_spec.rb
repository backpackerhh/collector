require 'rails_helper'

RSpec.describe EditionsDashboard, type: :dashboard do
  describe '#editions' do
    it 'returns expected records ordered by name' do
      create(:edition, name: 'Entourage: The Complete Series')
      create(:edition, name: 'Blade Runner: Maletín Edición Definitiva')
      create(:edition, name: 'The Godfather: 40th Anniversary Edition')

      dashboard = described_class.new

      expect(dashboard.editions.pluck(:name)).to eq([
        'Blade Runner: Maletín Edición Definitiva',
        'Entourage: The Complete Series',
        'The Godfather: 40th Anniversary Edition'
      ])
    end
  end
end
