require 'test_helper'

class FetchStockQuotesTest < ActiveSupport::TestCase
  test 'correctly returns hash of stock quotes for single stock' do
    VCR.use_cassette('yahoo_finance_api') do
      tickers = { tickers: ['GOOG'] }
      mock_time_zone = 'Eastern Time (US & Canada)'
      mock_date = '4:00pm 14/6/2016'
      mock_quote = {
        name: 'Alphabet Inc.',
        last_price: 718.27,
        date: Time.use_zone(mock_time_zone) { Time.zone.parse(mock_date) }
      }

      result = FetchStockQuotes.call tickers

      assert result.success?
      assert_equal 1, result.quotes.count
      assert_equal mock_quote[:name], result.quotes.first[:name]
      assert_equal mock_quote[:date], result.quotes.first[:last_trade]
      assert_equal mock_quote[:last_price], result.quotes.first[:last_price]
    end
  end

  test 'correctly returns hash of stock quotes for multiple stocks' do
    VCR.use_cassette('yahoo_finance_api') do
      tickers = { tickers: %w(GOOG YHOO) }

      result = FetchStockQuotes.call tickers

      assert result.success?
      assert_equal 2, result.quotes.count
      assert_equal 'Alphabet Inc.', result.quotes.first[:name]
      assert_equal 'Yahoo! Inc.', result.quotes.last[:name]
    end
  end

  test 'fails for api timeout' do
    VCR.use_cassette('yahoo_finance_api') do
      stub_request(:get, /[\s\S]*/).to_timeout
      tickers = { tickers: ['GOOG'] }

      result = FetchStockQuotes.call tickers

      refute result.success?
      assert_equal FetchStockQuotes::GENERAL_ERROR_MESSAGE, result.message
    end
  end
end
