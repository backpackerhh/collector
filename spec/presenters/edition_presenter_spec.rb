require 'rails_helper'

RSpec.describe EditionPresenter, type: :presenter do
  subject(:presenter) { described_class.new(edition, mock_action_view) }

  let(:edition) { create(:edition, name: 'Back To The Future Trilogy', country_code: 'US') }

  describe '#name' do
    it 'returns link to edit edition' do
      link = Nokogiri::HTML(presenter.name).css('a')[0]

      expect(link.attributes['href'].value).to eq("/editions/#{edition.id}/edit")
      expect(link.text).to eq('Back To The Future Trilogy')
    end
  end

  describe '#country' do
    it 'returns the name of the country according to its code' do
      expect(presenter.country).to eq('United States')
    end
  end

  describe '#formats' do
    let(:blu_ray) { create(:format, name: 'Blu-Ray') }
    let(:dvd)     { create(:format, name: 'DVD') }

    it 'returns default text when edition has no formats associated' do
      expect(presenter.formats).to eq('Not specified')
    end

    it 'returns name and number of discs for each format, separated by comma' do
      create(:edition_format, edition: edition, format: blu_ray, number_of_discs: 1)
      create(:edition_format, edition: edition, format: dvd, number_of_discs: 2)

      edition.reload

      expect(presenter.formats).to eq('1 Blu-Ray, 2 DVD')
    end
  end

  describe '#destroy' do
    it 'returns link to destroy edition' do
      link = Nokogiri::HTML(presenter.destroy).css('a')[0]

      expect(link.attributes['href'].value).to eq("/editions/#{edition.id}")
      expect(link.attributes['data-method'].value).to eq('delete')
      expect(link.attributes['data-confirm'].value).to eq('Are you sure?')
      expect(link.text).to eq('Delete')
    end
  end
end
