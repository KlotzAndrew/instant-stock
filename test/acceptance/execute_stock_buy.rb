require 'test_helper'
require 'integration_test_helper'

class ExecuteStockBuyTest < ActionDispatch::IntegrationTest
  setup do
    DatabaseCleaner.start
    @portfolio = FactoryGirl.create :portfolio
    @holding = FactoryGirl.create :cash_holding, portfolio: @portfolio

    @page = PortfolioPage.new
    @page.load(id: @portfolio.id)
  end

  teardown do
    DatabaseCleaner.clean
  end

  test 'visit portfolio' do
    assert @page.has_page_title?
    assert @page.has_messages_area?
    assert @page.has_trades_area?

    @page.has_messages? :count => 0

    @page.message_input.set('TSLA')
    @page.message_input.has_content?('TSLA')

    @page.message_input.native.send_keys(:return)
    @page.message_input.has_content?('')

    sleep 1
    assert_equal 1, enqueued_jobs.size
    perform_message_job enqueued_jobs.pop

    @page.has_messages? :count => 1
  end

  private

  def perform_message_job(job)
    job[:job].new.perform Message.last
  end
end
