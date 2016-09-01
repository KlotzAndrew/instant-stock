class SerializeHoldingsAndTrades
  include Interactor

  def call
    portfolio      = context.portfolio
    cash_holdings  = get_cash_holdings portfolio
    stock_holdings = get_stock_holdings portfolio

    context.cash_holdings  = cash_holdings
    context.stock_holdings = stock_holdings
  end

  private

  def get_cash_holdings(portfolio)
    cash_holdings = portfolio.cash_holdings.includes(:cash_trades)
    cash_holdings.map do |holding|
      {
        holding: serialize_cash_holding(holding),
        trades:  serialize_trades(holding.trades)
      }
    end
  end

  def serialize_trades(trades)
    trades.map do |trade|
      serialize_trade trade
    end
  end

  def serialize_trade(trade)
    trade.attributes
  end

  def serialize_cash_holding(holding)
    holding.attributes.tap do |hash|
      hash['current_total'] = holding.current_total
    end
  end

  def get_stock_holdings(portfolio)
    stock_holdings = portfolio.stock_holdings.includes(:stock_trades, :stock)
    stock_holdings.map do |holding|
      {
        holding: serialize_stock_holding(holding),
        trades: serialize_trades(holding.trades)
      }
    end
  end

  def serialize_stock_holding(holding)
    holding.attributes.tap do |hash|
      hash['current_total'] = holding.current_total
      hash['name']          = holding.stock.name
    end
  end
end
