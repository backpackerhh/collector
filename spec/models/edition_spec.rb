require 'rails_helper'

RSpec.describe Edition, type: :model do
  it { is_expected.to belong_to :distributor }
end
