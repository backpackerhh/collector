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
    it 'instantiates form object' do
      expect(EditionForm).to receive(:new).and_call_original

      post editions_path, params: { edition: attributes_for(:edition) }
    end

    context 'with valid params' do
      let(:distributor) { create(:distributor) }

      let(:valid_params) do
        { edition: attributes_for(:edition).merge(distributor_id: distributor.id) }
      end

      it 'creates a new edition' do
        expect {
          post editions_path, params: valid_params
        }.to change {
          Edition.count
        }.from(0).to 1
      end

      it 'redirects to edition edit page' do
        post editions_path, params: valid_params

        expect(response.location).to match(/editions\/\d+\/edit/)
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
        expect {
          post editions_path, params: invalid_params
        }.to_not change {
          Edition.count
        }
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
    let(:edition) { create(:edition, name: 'Back To The Future Trilogy') }
    let(:dvd)     { create(:format, name: 'DVD') }

    it 'instantiates form object' do
      expect(EditionForm).to receive(:new).and_call_original

      put edition_path(edition), params: { edition: attributes_for(:edition) }
    end

    context 'with valid params' do
      let(:valid_params) do
        {
          edition: {
            name: 'Back To The Future Trilogy CE',
            formats_attributes: {
              123456 => {
                'format_id'       => dvd.id,
                'number_of_discs' => 2,
                '_destroy'        => false
              }
            }
          }
        }
      end

      it 'updates edition and creates a new format for it' do
        expect {
          put edition_path(edition), params: valid_params
        }.to change {
          edition.reload
          edition.name
        }.from('Back To The Future Trilogy').to('Back To The Future Trilogy CE').and change {
          edition.formats.count
        }.from(0).to 1
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

      it 'does not update edition' do
        expect {
          put edition_path(edition), params: invalid_params
        }.to_not change {
          edition.reload
          edition.name
        }
      end

      it 're-renders form' do
        put edition_path(edition), params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#destroy' do
    let!(:edition) { create(:edition) }

    it 'redirects to editions list' do
      delete edition_path(edition)

      expect(response).to redirect_to(editions_path)
    end

    it 'deletes edition' do
      expect {
        delete edition_path(edition)
      }.to change {
        Edition.count
      }.by -1
    end

    it 'displays flash message' do
      delete edition_path(edition)

      follow_redirect!

      expect(response.body).to include('Edition was successfully destroyed.')
    end
  end
end
