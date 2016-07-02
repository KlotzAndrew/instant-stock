require 'capybara/rails'
require 'capybara/poltergeist'

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  poltergeist_options = {
    js_errors:         true,
    phantomjs_logger:  Rails.logger.info,
    window_size:       [2200, 1100]
  }

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, poltergeist_options)
  end

  Capybara.javascript_driver = :poltergeist
  Capybara.current_driver = :poltergeist
end
