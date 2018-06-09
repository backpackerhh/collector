require 'rails_helper'

RSpec.describe DistributorPresenter, type: :presenter do
  subject(:presenter) { described_class.new(distributor, mock_action_view) }

  let(:distributor) { create(:distributor, name: 'Disney') }

  include_examples 'common methods for presenters'do
    let(:record) { distributor }
  end
end
