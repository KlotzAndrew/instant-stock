require 'test_helper'

class PortfolioAutoTradeTest < ActiveSupport::TestCase
  test '#update creates minute bar and performs trade' do
    VCR.use_cassette('yahoo_finance_chart_api') do
      portfolio = FactoryGirl.create :portfolio, :with_cash_and_stock

      stock = portfolio.stocks[0]
      starting_minute_bars = stock.minute_bars.count

      holding = portfolio.stock_holdings[0]
      starting_trades = holding.trades.count

      AutoTrader.new.trade

      stock.reload
      assert_equal starting_minute_bars + 1, stock.minute_bars.count

      holding.reload
      assert_equal starting_trades + 1, holding.trades.count
    end
  end
end
