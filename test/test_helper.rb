require 'simplecov'
SimpleCov.start do
  add_filter '/config/'

  add_group 'Models', 'app/models'
  add_group 'Interactors', 'app/interactors'
  add_group 'Controllers', 'app/controllers'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'mocha/mini_test'
require 'webmock/minitest'
# require 'minitest/reporters'
# Minitest::Reporters.use!

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml
    # for all tests in alphabetical order.
    fixtures :all

    VCR.configure do |config|
      config.cassette_library_dir = 'fixtures/vcr_cassettes'
      config.hook_into :webmock
      config.default_cassette_options = {
        match_requests_on: [:uri],
        record:            :new_episodes
      }
    end
  end
end
