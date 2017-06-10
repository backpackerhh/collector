module WebpackTestBuild
  class << self
    attr_accessor :already_built
  end

  def self.run_webpack_if_necessary
    return if self.already_built && !timestamp_outdated?

    `RAILS_ENV=test bin/webpack`

    self.already_built = true

    File.open(file_with_timestamp, 'w') { |f| f.write(Time.now.utc.to_i) }
  end

  def self.timestamp_outdated?
    return true if !File.exists?(file_with_timestamp) || !current_timestamp

    current_timestamp < expected_timestamp
  end

  def self.file_with_timestamp
    Rails.root.join('tmp', 'webpack-spec-timestamp')
  end

  def self.current_timestamp
    File.read(file_with_timestamp).to_i
  end

  def self.expected_timestamp
    Dir[Rails.root.join('app', 'javascript', '**', '*')].map { |f| File.mtime(f).utc.to_i }.max
  end

  private_class_method :timestamp_outdated?, :file_with_timestamp, :current_timestamp, :expected_timestamp
end

RSpec.configure do |config|
  config.before(:each, :js) do
    WebpackTestBuild.run_webpack_if_necessary
  end
end
