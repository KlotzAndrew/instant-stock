require 'test_helper'

class PerformStockTradeTest < ActiveSupport::TestCase
  test 'creates trade with holding for portfolio' do
    mock_portfolio = Portfolio.new id: 9
    mock_stocks = [Stock.new]
    mock_holding = Holding.new
    mock_quantity = 1
    expected_trades = {}
    mock_params = {
      portfolio_id: mock_portfolio.id,
      stocks: mock_stocks,
      quantity: mock_quantity
    }
    Portfolio.expects(:find_by)
      .with(id: mock_portfolio.id)
      .returns(mock_portfolio)

    mock_holding_values = holding_values mock_stocks[0], mock_portfolio
    Holding.expects(:find_or_create_by)
      .with(mock_holding_values)
      .returns(mock_holding)

    mock_trade_values = trade_values mock_holding, mock_stocks[0]
    Trade.expects(:create).with(mock_trade_values)

    result = PerformStockTrade.call mock_params

    assert result.success?
    assert result.trades, expected_trades
  end

  test 'raises error when portfolio not found' do
    skip 'to implement'
  end

  test 'raises error when stocks or quantity missing' do
    skip 'should this fail interactor?'
  end

  private

  def trade_values(holding, stock)
    {
      holding_id:  holding.id,
      enter_price: stock.last_quote
    }
  end

  def holding_values(stock, portfolio)
    {
      stock_id: stock.id,
      portfolio_id: portfolio.id,
      active: true
    }
  end
end
