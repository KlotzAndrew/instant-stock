require 'capybara/rails'
require 'capybara/poltergeist'
require 'database_cleaner'
require 'sidekiq/testing'
require 'acceptance/page_objects'

Sidekiq::Testing.inline!

module ActionDispatch
  class IntegrationTest
    include Capybara::DSL
    include ActiveJob::TestHelper

    # Reset sessions and driver between tests
    # Use super wherever this method is redefined in your
    # individual test classes
    def teardown
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end

    poltergeist_options = {
      js_errors:         true,
      phantomjs_logger:  STDOUT,
      window_size:       [2200, 1100]
    }

    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new app, poltergeist_options
    end

    Capybara.javascript_driver = :poltergeist
    Capybara.current_driver = :poltergeist
    Capybara.server_port = 34_033

    Capybara.server = :puma

    DatabaseCleaner.strategy = :truncation
  end
end
