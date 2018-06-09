RSpec.shared_examples 'common methods for presenters' do
  describe '#name' do
    it 'returns link to edit record' do
      link = Nokogiri::HTML(presenter.name).css('a')[0]

      expect(link.attributes['href'].value).to eq(mock_action_view.url_for([:edit, record]))
      expect(link.text).to eq(record.name)
    end
  end

  describe '#destroy' do
    it 'returns link to destroy record' do
      link = Nokogiri::HTML(presenter.destroy).css('a')[0]

      expect(link.attributes['href'].value).to eq(mock_action_view.url_for(record))
      expect(link.attributes['data-method'].value).to eq('delete')
      expect(link.attributes['data-confirm'].value).to eq('Are you sure?')
      expect(link.text).to eq('Delete')
    end
  end
end
