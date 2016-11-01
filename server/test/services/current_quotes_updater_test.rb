require 'test_helper'

class CurrentQuotesUpdaterTest < ActiveSupport::TestCase
  test '#update fetches latest quotes and saves results' do
    portfolio = FactoryGirl.build :portfolio, :with_stock_holding
    stocks    = portfolio.stocks
    stock     = stocks[0]

    mock_quote = {
      ticker:         stock.ticker,
      name:           stock.name,
      last_price:     100.00,
      last_trade:     Time.zone.now,
      stock_exchange: 'ABC'
    }

    mock_fetcher = 'mock fetcher'
    FetchStockQuotes.expects(:call).with(
      tickers: stocks.map(&:ticker)
    ).returns(mock_fetcher)
    mock_fetcher.expects(:quotes).returns([mock_quote])
    MinuteBar.expects(:create).with(
      stock_id:    stock.id,
      data_source: mock_quote[:stock_exchange],
      close:       mock_quote[:last_price],
      quote_time:  mock_quote[:last_trade]
    )
    Stock.expects(:where).with(ticker: stock.ticker).returns(stocks)

    updater = CurrentQuotesUpdater.new(stocks)
    updater.update
  end
end
