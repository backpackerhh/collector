require 'rails_helper'

RSpec.describe 'Distributors', type: :request do
  describe '#index' do
    it 'returns successful response' do
      get distributors_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates dashboard' do
      expect(DistributorsDashboard).to receive(:new).and_call_original

      get distributors_path
    end
  end
end
