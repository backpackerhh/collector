require 'rails_helper'

RSpec.describe PackagingPresenter, type: :presenter do
  subject(:presenter) { described_class.new(packaging, mock_action_view) }

  let(:packaging) { create(:packaging, name: 'Digipak') }

  include_examples 'common methods for presenters'do
    let(:record) { packaging }
  end
end
