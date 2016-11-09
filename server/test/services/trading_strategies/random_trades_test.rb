require 'test_helper'

module TradingStrategies
  class RandomTradesTest < ActiveSupport::TestCase
    test '#calculate returns recommendations array' do
      portfolio = FactoryGirl.build :portfolio, :with_cash_and_stock

      expected_stock    = portfolio.stock_holdings[0].stock
      expected_quantity = 3
      RandomTrades.any_instance.expects(:rand).returns(expected_quantity)

      strategy = RandomTrades.new(
        portfolio.stock_holdings,
        portfolio.cash_holdings
      )
      recommendations = strategy.calculate

      recommendation = recommendations[0]
      assert_equal expected_stock, recommendation[:stock]
      assert_equal expected_quantity, recommendation[:quantity]
    end
  end
end
