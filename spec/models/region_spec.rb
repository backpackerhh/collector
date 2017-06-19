require 'rails_helper'

RSpec.describe Region, type: :model do
  it { is_expected.to belong_to :format }
end
