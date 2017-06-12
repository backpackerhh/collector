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

  describe '#new' do
    it 'returns successful response' do
      get new_packaging_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(PackagingForm).to receive(:new).and_call_original

      get new_packaging_path
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:valid_params) do
        { packaging: attributes_for(:packaging) }
      end

      it 'instantiates form object' do
        expect(PackagingForm).to receive(:new).and_call_original

        post packagings_path, params: valid_params
      end

      it 'creates a new packaging' do
        expect { post packagings_path, params: valid_params }.to change { Packaging.count }.from(0).to 1
      end

      it 'redirects to packagings list' do
        post packagings_path, params: valid_params

        expect(response).to redirect_to(packagings_path)
      end

      it 'displays flash message' do
        post packagings_path, params: valid_params

        follow_redirect!

        expect(response.body).to include('Packaging was successfully created.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { packaging: { name: '' } }
      end

      it 'does not create a new packaging' do
        expect { post packagings_path, params: invalid_params }.to_not change { Packaging.count }
      end

      it 're-renders form' do
        post packagings_path, params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#edit' do
    let(:packaging) { create(:packaging) }

    it 'returns successful response' do
      get edit_packaging_path(packaging)

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(PackagingForm).to receive(:new).and_call_original

      get edit_packaging_path(packaging)
    end
  end

  describe '#update' do
    let(:packaging) { create(:packaging, name: 'Digipak') }

    context 'with valid params' do
      let(:valid_params) do
        { packaging: { name: 'Digibook' } }
      end

      it 'instantiates form object' do
        expect(PackagingForm).to receive(:new).and_call_original

        put packaging_path(packaging), params: valid_params
      end

      it 'updates packaging' do
        expect { put packaging_path(packaging), params: valid_params }.to change { packaging.reload.name }
      end

      it 'redirects to packagings list' do
        put packaging_path(packaging), params: valid_params

        expect(response).to redirect_to(packagings_path)
      end

      it 'displays flash message' do
        put packaging_path(packaging), params: valid_params

        follow_redirect!

        expect(response.body).to include('Packaging was successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { packaging: { name: '' } }
      end

      it 'does not create a new packaging' do
        expect { put packaging_path(packaging), params: invalid_params }.to_not change { packaging.reload.name }
      end

      it 're-renders form' do
        put packaging_path(packaging), params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end
end
