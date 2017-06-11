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

  describe '#new' do
    it 'returns successful response' do
      get new_format_path

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(FormatForm).to receive(:new).and_call_original

      get new_format_path
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:valid_params) do
        { format: attributes_for(:format) }
      end

      it 'instantiates form object' do
        expect(FormatForm).to receive(:new).and_call_original

        post formats_path, params: valid_params
      end

      it 'creates a new format' do
        expect { post formats_path, params: valid_params }.to change { Format.count }.from(0).to 1
      end

      it 'redirects to formats list' do
        post formats_path, params: valid_params

        expect(response).to redirect_to(formats_path)
      end

      it 'displays flash message' do
        post formats_path, params: valid_params

        follow_redirect!

        expect(response.body).to include('Format was successfully created.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { format: { name: '' } }
      end

      it 'does not create a new format' do
        expect { post formats_path, params: invalid_params }.to_not change { Format.count }
      end

      it 're-renders form' do
        post formats_path, params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#edit' do
    let(:format) { create(:format) }

    it 'returns successful response' do
      get edit_format_path(format)

      expect(response).to have_http_status(:success)
    end

    it 'instantiates form object' do
      expect(FormatForm).to receive(:new).and_call_original

      get edit_format_path(format)
    end
  end

  describe '#update' do
    let(:format) { create(:format, name: 'Paramount') }

    context 'with valid params' do
      let(:valid_params) do
        { format: { name: 'Universal' } }
      end

      it 'instantiates form object' do
        expect(FormatForm).to receive(:new).and_call_original

        put format_path(format), params: valid_params
      end

      it 'updates format' do
        expect { put format_path(format), params: valid_params }.to change { format.reload.name }
      end

      it 'redirects to formats list' do
        put format_path(format), params: valid_params

        expect(response).to redirect_to(formats_path)
      end

      it 'displays flash message' do
        put format_path(format), params: valid_params

        follow_redirect!

        expect(response.body).to include('Format was successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { format: { name: '' } }
      end

      it 'does not create a new format' do
        expect { put format_path(format), params: invalid_params }.to_not change { format.reload.name }
      end

      it 're-renders form' do
        put format_path(format), params: invalid_params

        expect(response).to_not have_http_status(:redirect)
      end
    end
  end

  describe '#destroy' do
    let!(:format) { create(:format) }

    it 'redirects to formats list' do
      delete format_path(format)

      expect(response).to redirect_to(formats_path)
    end

    it 'deletes format' do
      expect { delete format_path(format) }.to change { Format.count }.by -1
    end

    it 'displays flash message' do
      delete format_path(format)

      follow_redirect!

      expect(response.body).to include('Format was successfully destroyed.')
    end
  end
end
