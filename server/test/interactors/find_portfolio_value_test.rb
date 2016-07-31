require 'test_helper'

class FindPortfolioValueTest < ActiveSupport::TestCase
  test '#call returns value with cash_holding and stocks' do
    portfolio    = FactoryGirl.build :portfolio
    cash_holding = FactoryGirl.build :cash_holding, portfolio: portfolio
    cash_trade   = FactoryGirl.build :cash_trade
    cash_holding.cash_trades << cash_trade

    portfolio.cash_holdings << cash_holding
    stock   = FactoryGirl.build :stock
    holding = FactoryGirl.build :stock_holding,
                                stock: stock,
                                portfolio: portfolio
    portfolio.stock_holdings << holding
    trade = FactoryGirl.build :stock_trade, stock_holding: holding
    holding.stock_trades << trade

    result = FindPortfolioValue.call(portfolio: portfolio)

    expected_cash_value  = cash_holding.current_total
    expected_stock_value = trade.quantity * stock.last_quote
    expected_value       = expected_cash_value + expected_stock_value
    assert result.success?
    assert_equal expected_value, result.value
  end

  test '#call fails without portfolio' do
    skip 'tbd'
  end
end
