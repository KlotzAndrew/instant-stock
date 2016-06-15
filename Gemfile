source 'https://rubygems.org'


gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'interactor'
require 'open-uri'

gem 'jquery-rails'
gem 'turbolinks', '~> 5.x'
gem 'jbuilder', '~> 2.0'
gem 'rubocop'
gem 'sidekiq'
gem 'sinatra', github: 'sinatra/sinatra', branch: 'master'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'pry-rails'
  # gem 'minitest-rails'
  # gem 'minitest-reporters'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano'
# gem 'capistrano-rails'
end

group :test do
  gem 'webmock'
  gem 'vcr'
  gem 'mocha'
  gem 'minitest-focus'
  gem 'simplecov', :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

