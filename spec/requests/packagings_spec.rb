require 'rails_helper'

RSpec.describe 'Packagings', type: :request do
  describe '#index' do
    it 'returns successful response' do
      get packagings_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates dashboard' do
      expect(PackagingsDashboard).to receive(:new).and_call_original

      get packagings_path
    end
  end
end
