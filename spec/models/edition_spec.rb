require 'rails_helper'

RSpec.describe Edition, type: :model do
  it { is_expected.to belong_to :distributor }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :distributor_id }
  it { is_expected.to validate_presence_of :country_code }
  it { is_expected.to validate_presence_of :release_date }

  it { is_expected.to delegate_method(:name).to(:distributor).with_prefix }
end
