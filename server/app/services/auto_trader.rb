class AutoTrader
  def initialize(portfolio = promo_portfolio)
    @portfolio = portfolio
  end

  def trade
    update_stock_prices

    stock_orders = calculate_stock_orders

    execute_orders(stock_orders)
  end

  private

  def execute_orders(orders)
    orders.each do |order|
      PerformStockTrade.call order
    end
  end

  def calculate_stock_orders
    holding_updater = StockOrderCalculator.new(
      @portfolio,
      TradingStrategies::RandomTrades
    )
    holding_updater.calculate
  end

  def update_stock_prices
    quote_updater = CurrentQuotesUpdater.new(@portfolio.stocks)
    quote_updater.update
  end

  def promo_portfolio
    FindPromoPortfolio.call.portfolio
  end
end
