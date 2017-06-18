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

  describe '#new' do
    it 'returns successful response' do
      get new_edition_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(EditionForm).to receive(:new).and_call_original

      get new_edition_path
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:distributor) { create(:distributor) }

      let(:valid_params) do
        { edition: attributes_for(:edition).merge(distributor_id: distributor.id) }
      end

      it 'instantiates form object' do
        expect(EditionForm).to receive(:new).and_call_original

        post editions_path, params: valid_params
      end

      it 'creates a new edition' do
        expect { post editions_path, params: valid_params }.to change { Edition.count }.from(0).to 1
      end

      it 'redirects to editions list' do
        post editions_path, params: valid_params

        expect(response).to redirect_to(editions_path)
      end

      it 'displays flash message' do
        post editions_path, params: valid_params

        follow_redirect!

        expect(response.body).to include('Edition was successfully created.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { edition: { name: '' } }
      end

      it 'does not create a new edition' do
        expect { post editions_path, params: invalid_params }.to_not change { Edition.count }
      end

      it 're-renders form' do
        post editions_path, params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#edit' do
    let(:edition) { create(:edition) }

    it 'returns successful response' do
      get edit_edition_path(edition)

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(EditionForm).to receive(:new).and_call_original

      get edit_edition_path(edition)
    end
  end

  describe '#update' do
    let(:edition) { create(:edition, name: 'Paramount') }

    context 'with valid params' do
      let(:valid_params) do
        { edition: { name: 'Universal' } }
      end

      it 'instantiates form object' do
        expect(EditionForm).to receive(:new).and_call_original

        put edition_path(edition), params: valid_params
      end

      it 'updates edition' do
        expect { put edition_path(edition), params: valid_params }.to change { edition.reload.name }
      end

      it 'redirects to editions list' do
        put edition_path(edition), params: valid_params

        expect(response).to redirect_to(editions_path)
      end

      it 'displays flash message' do
        put edition_path(edition), params: valid_params

        follow_redirect!

        expect(response.body).to include('Edition was successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { edition: { name: '' } }
      end

      it 'does not create a new edition' do
        expect { put edition_path(edition), params: invalid_params }.to_not change { edition.reload.name }
      end

      it 're-renders form' do
        put edition_path(edition), params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end
end
