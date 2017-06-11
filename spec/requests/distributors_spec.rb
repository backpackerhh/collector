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

  describe '#new' do
    it 'returns successful response' do
      get new_distributor_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(DistributorForm).to receive(:new).and_call_original

      get new_distributor_path
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:valid_params) do
        { distributor: attributes_for(:distributor) }
      end

      it 'instantiates form object' do
        expect(DistributorForm).to receive(:new).and_call_original

        post distributors_path, params: valid_params
      end

      it 'creates a new distributor' do
        expect { post distributors_path, params: valid_params }.to change { Distributor.count }.from(0).to 1
      end

      it 'redirects to distributors list' do
        post distributors_path, params: valid_params

        expect(response).to redirect_to(distributors_path)
      end

      it 'displays flash message' do
        post distributors_path, params: valid_params

        follow_redirect!

        expect(response.body).to include('Distributor was successfully created.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { distributor: { name: '' } }
      end

      it 'does not create a new distributor' do
        expect { post distributors_path, params: invalid_params }.to_not change { Distributor.count }
      end

      it 're-renders form' do
        post distributors_path, params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#edit' do
    let(:distributor) { create(:distributor) }

    it 'returns successful response' do
      get edit_distributor_path(distributor)

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(DistributorForm).to receive(:new).and_call_original

      get edit_distributor_path(distributor)
    end
  end

  describe '#update' do
    let(:distributor) { create(:distributor, name: 'Paramount') }

    context 'with valid params' do
      let(:valid_params) do
        { distributor: { name: 'Universal' } }
      end

      it 'instantiates form object' do
        expect(DistributorForm).to receive(:new).and_call_original

        put distributor_path(distributor), params: valid_params
      end

      it 'updates distributor' do
        expect { put distributor_path(distributor), params: valid_params }.to change { distributor.reload.name }
      end

      it 'redirects to distributors list' do
        put distributor_path(distributor), params: valid_params

        expect(response).to redirect_to(distributors_path)
      end

      it 'displays flash message' do
        put distributor_path(distributor), params: valid_params

        follow_redirect!

        expect(response.body).to include('Distributor was successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { distributor: { name: '' } }
      end

      it 'does not create a new distributor' do
        expect { put distributor_path(distributor), params: invalid_params }.to_not change { distributor.reload.name }
      end

      it 're-renders form' do
        put distributor_path(distributor), params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#destroy' do
    let!(:distributor) { create(:distributor) }

    it 'redirects to distributors list' do
      delete distributor_path(distributor)

      expect(response).to redirect_to(distributors_path)
    end

    it 'deletes distributor' do
      expect { delete distributor_path(distributor) }.to change { Distributor.count }.by -1
    end

    it 'displays flash message' do
      delete distributor_path(distributor)

      follow_redirect!

      expect(response.body).to include('Distributor was successfully destroyed.')
    end
  end
end
