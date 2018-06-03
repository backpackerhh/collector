require 'rails_helper'

RSpec.describe Packaging, type: :model do
  it { is_expected.to have_many :edition_packagings }
  it { is_expected.to have_many(:editions).through :edition_packagings }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
end
