require 'test_helper'

class ReturnPortfolioStockMinutesTest < ActiveSupport::TestCase
  test '#call updates quotes and returns minute bars' do
    portfolio = FactoryGirl.build :portfolio, :with_stock_holding

    UpdateStocksMinuteBars.expects(:call).with(stocks: portfolio.stocks)

    expected_minute_bars = []
    found_minute_bars = mock 'found minute bars'
    found_minute_bars.expects(:stock_minute_bars).returns(expected_minute_bars)
    mock_params = {
      stocks:       portfolio.stocks,
      history_time: ReturnPortfolioStockMinutes::DEFAULT_HISTORY_MINUTES
    }
    FindStockMinuteBars.expects(:call).with(mock_params).returns(found_minute_bars)

    result = ReturnPortfolioStockMinutes.call portfolio: portfolio

    assert result.success?
    assert_equal result.stock_minute_bars, expected_minute_bars
  end
end
