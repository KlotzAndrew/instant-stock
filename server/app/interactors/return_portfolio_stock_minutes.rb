class ReturnPortfolioStockMinutes
  include Interactor

  DEFAULT_HISTORY_MINUTES = 1440

  def call
    @stocks = context.portfolio.stocks
    update_minute_bars
    context.stock_minute_bars = get_minute_bars
  end

  private

  def get_minute_bars
    params = {
      stocks:       @stocks,
      history_minutes: DEFAULT_HISTORY_MINUTES
    }
    result = FindStockMinuteBars.call params
    result.stock_minute_bars
  end

  def update_minute_bars
    UpdateStocksMinuteBars.call stocks: @stocks
  end
end
