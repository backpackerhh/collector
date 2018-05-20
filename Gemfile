source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.2.0'

# Database
gem 'pg', '~> 0.18'

# App server
gem 'puma', '~> 3.7'

# Assets
gem 'webpacker'

# JSON APIs
gem 'jbuilder', '~> 2.5'

# Template engine
gem 'slim-rails'

# Forms
gem 'country_select'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'yard', require: false
end

group :test do
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
  gem 'faker'
end
