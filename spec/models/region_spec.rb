require 'rails_helper'

RSpec.describe Region, type: :model do
  it { is_expected.to belong_to :format }

  it { is_expected.to delegate_method(:name).to(:format).with_prefix }
end
