require 'rails_helper'

RSpec.describe Distributor, type: :model do
  it { is_expected.to have_many :editions }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
end
