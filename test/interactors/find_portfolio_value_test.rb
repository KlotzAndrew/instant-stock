require 'test_helper'

class FindPortfolioValueTest < ActiveSupport::TestCase
  test '#call returns value with cash_holding and stocks' do
    portfolio    = FactoryGirl.build :portfolio
    cash_holding = FactoryGirl.build :cash_holding, portfolio: portfolio
    portfolio.cash_holdings << cash_holding
    stock = FactoryGirl.build :stock
    holding = FactoryGirl.build :holding, stock: stock, portfolio: portfolio
    portfolio.holdings << holding
    trade = FactoryGirl.build :trade, holding: holding
    holding.trades << trade

    result = FindPortfolioValue.call(portfolio: portfolio)

    expected_cash_value = cash_holding.amount
    expected_stock_value = trade.quantity * stock.last_quote
    expected_value = expected_cash_value + expected_stock_value
    assert result.success?
    assert_equal expected_value, result.value
  end

  test '#call fails without portfolio' do
    skip 'tbd'
  end
end
