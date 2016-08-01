require 'simplecov'
SimpleCov.start do
  add_filter '/config/'

  add_group 'Models', 'app/models'
  add_group 'Interactors', 'app/interactors'
  add_group 'Controllers', 'app/controllers'
  add_group 'Jobs', 'app/jobs'
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
    self.use_transactional_tests = false

    VCR.configure do |c|
      c.cassette_library_dir = 'fixtures/vcr_cassettes'
      c.hook_into :webmock
      c.ignore_localhost = true
      c.default_cassette_options = {
        match_requests_on: [:uri],
        record:            :new_episodes
      }
    end
  end
end
