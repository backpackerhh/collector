require 'rails_helper'

RSpec.describe Edition, type: :model do
  it { is_expected.to belong_to :distributor }
  it { is_expected.to have_many(:formats).class_name('EditionFormat').dependent :destroy }
  it { is_expected.to accept_nested_attributes_for(:formats).allow_destroy(true) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :distributor_id }
  it { is_expected.to validate_presence_of :country_code }
  it { is_expected.to validate_presence_of :release_date }
  it { is_expected.to validate_presence_of(:formats).on(:update) }

  it { is_expected.to delegate_method(:name).to(:distributor).with_prefix }
end
