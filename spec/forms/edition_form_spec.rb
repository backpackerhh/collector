require 'rails_helper'

RSpec.describe EditionForm do
  subject(:edition_form) { described_class.new(edition) }

  let(:edition) { Edition.new }

  describe '.model_name' do
    it 'returns all kinds of naming-related information' do
      expect(edition_form.class.model_name.name).to eq('Edition')
    end
  end

  describe '#submit(params)' do
    let(:paramount) { create(:distributor, name: 'Paramount') }
    let(:dvd)       { create(:format, name: 'DVD') }
    let(:blu_ray)   { create(:format, name: 'Blu-ray') }

    context 'for a new record' do
      let(:valid_params) do
        {
          name: 'The Godfather: 40th Anniversary Edition',
          distributor_id: paramount.id,
          country_code: 'IT',
          release_date: '2012-06-13'
        }
      end

      it 'preloads its own fields with given params' do
        edition_form.submit(valid_params)

        expect(edition_form.name).to eq('The Godfather: 40th Anniversary Edition')
        expect(edition_form.distributor_id).to eq(paramount.id)
        expect(edition_form.country_code).to eq('IT')
        expect(edition_form.release_date.to_s).to eq('2012-06-13')
        expect(edition_form.formats.size).to eq(0)
      end

      context 'with valid params' do
        it 'creates a new edition' do
          expect {
            edition_form.submit(valid_params)
          }.to change {
            Edition.count
          }.from(0).to 1
        end

        it 'returns true' do
          expect(edition_form.submit(valid_params)).to be true
        end
      end

      context 'with invalid params' do
        it 'promotes errors to form fields' do
          edition_form.submit({})

          expect(edition_form.errors[:name]).to include "can't be blank"
          expect(edition_form.errors[:distributor_id]).to include "can't be blank"
          expect(edition_form.errors[:country_code]).to include "can't be blank"
          expect(edition_form.errors[:release_date]).to include "can't be blank"
          expect(edition_form.errors[:formats]).to_not include "can't be blank"
        end

        it 'does not create a new edition' do
          expect {
            edition_form.submit({})
          }.to_not change {
            Edition.count
          }
        end

        it 'returns false' do
          expect(edition_form.submit({})).to be false
        end
      end
    end

    context 'for an existing record' do
      let(:name)    { 'The Godfather: 40th Anniversary Edition' }
      let(:date)    { '2012-06-13' }
      let(:edition) { create(:edition, name: name, distributor: paramount, country_code: 'IT', release_date: date) }
      let(:valid_params) do
        {
          name: 'The Godfather: 40th Anniv. Edition',
          formats_attributes: {
            0 => {
              'format_id'       => dvd.id,
              'number_of_discs' => 1,
              '_destroy'        => false
            }
          }
        }
      end

      it 'preloads its own fields with given params' do
        edition_form.submit(valid_params)

        expect(edition_form.name).to eq('The Godfather: 40th Anniv. Edition')
        expect(edition_form.distributor_id).to eq(paramount.id)
        expect(edition_form.country_code).to eq('IT')
        expect(edition_form.release_date.to_s).to eq('2012-06-13')
        expect(edition_form.formats.size).to eq(1)
        expect(edition_form.formats.first.format_id).to eq(dvd.id)
        expect(edition_form.formats.first.edition_id).to eq(edition.id)
        expect(edition_form.formats.first.number_of_discs).to eq(1)
      end

      context 'with valid params' do
        it 'updates expected attributes and creates a new format for edition' do
          expect {
            edition_form.submit(valid_params)
          }.to change {
            edition.name
          }.from('The Godfather: 40th Anniversary Edition').to('The Godfather: 40th Anniv. Edition').and change {
            edition.formats.count
          }.from(0).to 1
        end

        it 'is able to update attributes for an associated format' do
          edition_format = create(:edition_format, edition: edition, format: dvd, number_of_discs: 1)
          valid_params = {
            formats_attributes: {
              0 => {
                'id'              => edition_format.id,
                'format_id'       => dvd.id,
                'number_of_discs' => 2,
                '_destroy'        => false
              }
            }
          }

          expect {
            edition_form.submit(valid_params)
          }.to change {
            edition.reload
            edition_format.reload
            edition_format.number_of_discs
          }.from(1).to(2)
        end

        it 'is able to remove an associated format as long as it is replaced with another one' do
          edition_format = create(:edition_format, edition: edition, format: dvd, number_of_discs: 1)
          valid_params = {
            formats_attributes: {
              0 => {
                'id'              => edition_format.id,
                'format_id'       => dvd.id,
                'number_of_discs' => 1,
                '_destroy'        => true
              },
              123456 => {
                'format_id'       => blu_ray.id,
                'number_of_discs' => 2,
                '_destroy'        => false
              }
            }
          }

          expect {
            edition_form.submit(valid_params)
          }.to change {
            edition.reload

            first_format = edition.formats.first
            first_format.format_id
          }.from(dvd.id).to blu_ray.id
        end

        it 'returns true' do
          expect(edition_form.submit(valid_params)).to be true
        end
      end

      context 'with invalid params' do
        it 'promotes errors to form fields' do
          edition_form.submit({})

          expect(edition_form.errors[:name]).to_not include "can't be blank"
          expect(edition_form.errors[:distributor_id]).to_not include "can't be blank"
          expect(edition_form.errors[:country_code]).to_not include "can't be blank"
          expect(edition_form.errors[:release_date]).to_not include "can't be blank"
          expect(edition_form.errors[:formats]).to include "can't be blank"
        end

        it 'does not create a new format for edition' do
          expect {
            edition_form.submit({})
          }.to_not change {
            EditionFormat.count
          }
        end

        it 'returns false' do
          expect(edition_form.submit({})).to be false
        end
      end
    end
  end

  describe '#distributors' do
    it 'returns expected records ordered by name' do
      create(:distributor, name: 'Universal')
      create(:distributor, name: '20th Century Fox')

      expect(edition_form.distributors.pluck(:name)).to eq(['20th Century Fox', 'Universal'])
    end
  end

  describe '#countries' do
    it 'returns codes for all priority countries' do
      expect(edition_form.countries).to match_array(%w(ES GB US FR DE IT JP KR CA CN CZ SE))
    end
  end

  describe '#edition_formats' do
    it 'returns expected records ordered by name' do
      create(:format, name: 'DVD')
      create(:format, name: 'Blu-ray')

      expect(edition_form.edition_formats.pluck(:name)).to eq(['Blu-ray', 'DVD'])
    end
  end
end
