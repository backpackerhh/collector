require 'rails_helper'

RSpec.describe Edition, type: :model do
  it { is_expected.to belong_to :distributor }

  it { is_expected.to delegate_method(:name).to(:distributor).with_prefix }
end
