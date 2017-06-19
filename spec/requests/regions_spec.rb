require 'rails_helper'

RSpec.describe 'Regions', type: :request do
  describe '#index' do
    it 'returns successful response' do
      get regions_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates dashboard' do
      expect(RegionsDashboard).to receive(:new).and_call_original

      get regions_path
    end
  end
end
