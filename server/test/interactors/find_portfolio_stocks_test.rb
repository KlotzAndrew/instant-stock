require 'test_helper'

class FindPortfolioStocksTest < ActiveSupport::TestCase
  test '#call gets stocks to be updated' do
    portfolio = FactoryGirl.build :portfolio, :with_stock_holding
    stocks    = portfolio.stocks

    result = FindPortfolioStocks.call portfolio: portfolio

    assert result.success?
    assert_equal stocks, result.stocks
  end
end
