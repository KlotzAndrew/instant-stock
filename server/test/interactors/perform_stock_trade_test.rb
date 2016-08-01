require 'test_helper'

class PerformStockTradeTest < ActiveSupport::TestCase
  test 'creates trade with holding for portfolio' do
    mock_portfolio = FactoryGirl.build :portfolio, :with_cash
    mock_cash_holding = mock_portfolio.cash_holdings.first

    mock_stocks = [FactoryGirl.build(:stock)]
    mock_stock_holding = FactoryGirl.build :stock_holding

    mock_quantity = 1
    mock_params = {
      portfolio_id: mock_portfolio.id,
      stocks: mock_stocks,
      quantity: mock_quantity
    }
    Portfolio.expects(:find_by)
             .with(id: mock_portfolio.id)
             .returns(mock_portfolio)

    mock_stock_holding_values = stock_holding_values mock_stocks[0],
                                                     mock_portfolio
    StockHolding.expects(:find_or_create_by)
                .with(mock_stock_holding_values)
                .returns(mock_stock_holding)

    mock_cash_holding_values = cash_holding_values mock_stocks[0],
                                                   mock_portfolio
    CashHolding.expects(:find_or_create_by)
               .with(mock_cash_holding_values)
               .returns(mock_cash_holding)

    mock_stock_trade_values = stock_trade_values mock_stock_holding,
                                                 mock_stocks[0]
    StockTrade.expects(:create).with(mock_stock_trade_values)

    mock_value = mock_quantity * mock_stocks[0].last_quote
    mock_cash_trade_values = cash_trade_values mock_cash_holding, mock_value
    CashTrade.expects(:create).with(mock_cash_trade_values)

    result = PerformStockTrade.call mock_params

    assert result.success?
    # assert result.trades, expected_trades
  end

  test 'raises error when portfolio not found' do
    skip 'to implement'
  end

  test 'raises error when stocks or quantity missing' do
    skip 'should this fail interactor?'
  end

  private

  def stock_trade_values(holding, stock)
    {
      stock_holding_id:  holding.id,
      enter_price: stock.last_quote,
      quantity: 1
    }
  end

  def cash_trade_values(holding, value)
    {
      cash_holding_id:  holding.id,
      quantity: value * -1
    }
  end

  def stock_holding_values(stock, portfolio)
    {
      stock_id: stock.id,
      portfolio_id: portfolio.id,
      active: true
    }
  end

  def cash_holding_values(stock, portfolio)
    {
      portfolio_id: portfolio.id,
      currency: stock.currency
    }
  end
end
