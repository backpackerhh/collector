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

  describe '#new' do
    it 'returns successful response' do
      get new_region_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(RegionForm).to receive(:new).and_call_original

      get new_region_path
    end
  end

  describe '#create' do
      let(:format) { create(:format) }

    context 'with valid params' do
      let(:valid_params) do
        { region: attributes_for(:region).merge(format_id: format.id) }
      end

      it 'instantiates form object' do
        expect(RegionForm).to receive(:new).and_call_original

        post regions_path, params: valid_params
      end

      it 'creates a new region' do
        expect { post regions_path, params: valid_params }.to change { Region.count }.from(0).to 1
      end

      it 'redirects to regions list' do
        post regions_path, params: valid_params

        expect(response).to redirect_to(regions_path)
      end

      it 'displays flash message' do
        post regions_path, params: valid_params

        follow_redirect!

        expect(response.body).to include('Region was successfully created.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { region: { name: '' } }
      end

      it 'does not create a new region' do
        expect { post regions_path, params: invalid_params }.to_not change { Region.count }
      end

      it 're-renders form' do
        post regions_path, params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#edit' do
    let(:region) { create(:region) }

    it 'returns successful response' do
      get edit_region_path(region)

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(RegionForm).to receive(:new).and_call_original

      get edit_region_path(region)
    end
  end

  describe '#update' do
    let(:region) { create(:region, name: 'Paramount') }

    context 'with valid params' do
      let(:valid_params) do
        { region: { name: 'Universal' } }
      end

      it 'instantiates form object' do
        expect(RegionForm).to receive(:new).and_call_original

        put region_path(region), params: valid_params
      end

      it 'updates region' do
        expect { put region_path(region), params: valid_params }.to change { region.reload.name }
      end

      it 'redirects to regions list' do
        put region_path(region), params: valid_params

        expect(response).to redirect_to(regions_path)
      end

      it 'displays flash message' do
        put region_path(region), params: valid_params

        follow_redirect!

        expect(response.body).to include('Region was successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { region: { name: '' } }
      end

      it 'does not create a new region' do
        expect { put region_path(region), params: invalid_params }.to_not change { region.reload.name }
      end

      it 're-renders form' do
        put region_path(region), params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#destroy' do
    let!(:region) { create(:region) }

    it 'redirects to regions list' do
      delete region_path(region)

      expect(response).to redirect_to(regions_path)
    end

    it 'deletes region' do
      expect { delete region_path(region) }.to change { Region.count }.by -1
    end

    it 'displays flash message' do
      delete region_path(region)

      follow_redirect!

      expect(response.body).to include('Region was successfully destroyed.')
    end
  end
end
