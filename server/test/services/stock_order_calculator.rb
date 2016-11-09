require 'test_helper'

class StockOrderCalculatorTest < ActiveSupport::TestCase
  test '#perform trades on recommendations from strategy' do
    portfolio = FactoryGirl.build :portfolio, :with_cash_and_stock
    strategy  = TradingStrategies::RandomTrades

    recommendations = [
      {
        stock: portfolio.stock_holdings.first.stock,
        quantity: 66
      }
    ]

    mock_strategy = 'mock strategy'
    mock_strategy.expects(:calculate).returns(recommendations)
    TradingStrategies::RandomTrades.expects(:new).with(
      portfolio.stock_holdings,
      portfolio.cash_holdings
    ).returns(mock_strategy)

    order = recommendations[0]
    order[:portfolio_id] = portfolio.id
    order[:stocks] = order[:stock]

    trader = StockOrderCalculator.new(portfolio, strategy)
    result = trader.calculate

    assert_equal [order], result
  end
end
