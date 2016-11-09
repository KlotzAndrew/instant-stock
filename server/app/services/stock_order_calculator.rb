class StockOrderCalculator
  def initialize(portfolio, strategy)
    @portfolio = portfolio
    @strategy  = strategy
  end

  def calculate
    trade_recommendations = calculate_trades

    trade_recommendations.each do |recommendation|
      recommendation[:portfolio_id] = @portfolio.id
      recommendation[:stocks] = [recommendation[:stock]]
    end
  end

  private

  def calculate_trades
    trading_strategy = @strategy.new(
      @portfolio.stock_holdings,
      @portfolio.cash_holdings
    )
    trading_strategy.calculate
  end
end
