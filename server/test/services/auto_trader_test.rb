require 'test_helper'

class AutoTraderTest < ActiveSupport::TestCase
  test '#trade gets new quotes & updates position' do
    portfolio = FactoryGirl.build :portfolio, :with_stock_holding

    mock_promo_finder = 'mock promo'
    FindPromoPortfolio.expects(:call).returns(mock_promo_finder)
    mock_promo_finder.expects(:portfolio).returns(portfolio)

    mock_quote_updater = 'mock quote updater'
    CurrentQuotesUpdater.expects(:new).with(
      portfolio.stocks
    ).returns(mock_quote_updater)
    mock_quote_updater.expects(:update)

    mock_holding_updater = 'mock holding updater'
    mock_order = { stock: 'some stock' }
    StockOrderCalculator.expects(:new).with(
      portfolio,
      TradingStrategies::RandomTrades
    ).returns(mock_holding_updater)
    mock_holding_updater.expects(:calculate).returns([mock_order])

    PerformStockTrade.expects(:call).with(mock_order)

    AutoTrader.new.trade
  end
end
