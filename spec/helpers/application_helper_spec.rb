require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '.present(model, presenter: nil)' do
    let(:edition) { instance_double('Edition', class: 'Edition') }
    let(:view)    { any_args }

    it 'instantiates default presenter for given resource' do
      expect(EditionPresenter).to receive(:new).with(edition, view)

      helper.present(edition)
    end

    it 'instantiates expected presenter for given resource' do
      unknown_presenter = double('UnknownPresenter')

      expect(unknown_presenter).to receive(:new).with(edition, view)

      helper.present(edition, presenter: unknown_presenter)
    end
  end
end
