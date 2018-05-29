require_relative 'helpers/presenter_helpers'

RSpec.configure do |config|
  config.include PresenterHelpers, type: :presenter
end
