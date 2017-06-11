require 'rails_helper'

RSpec.describe 'Formats', type: :request do
  describe '#index' do
    it 'returns successful response' do
      get formats_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates dashboard' do
      expect(FormatsDashboard).to receive(:new).and_call_original

      get formats_path
    end
  end
end
