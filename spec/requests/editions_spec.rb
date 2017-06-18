require 'rails_helper'

RSpec.describe 'Editions', type: :request do
  describe '#index' do
    it 'returns successful response' do
      get editions_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates dashboard' do
      expect(EditionsDashboard).to receive(:new).and_call_original

      get editions_path
    end
  end
end
