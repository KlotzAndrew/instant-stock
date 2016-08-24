class FindStockMinuteBars
  include Interactor

  DEFAULT_HISTORY_MINUTES = 90

  def call
    @end_time        = Time.zone.now
    @stocks          = context.stocks
    @history_minutes = context.history_minutes || DEFAULT_HISTORY_MINUTES

    stock_minute_bars = find_stock_minute_bars

    context.stock_minute_bars = stock_minute_bars
  end

  private

  def find_stock_minute_bars
    @stocks.each_with_object({}) do |stock, hash|
      hash[stock.id] = (get_minute_bars stock)
    end
  end

  def get_minute_bars(stock)
    bars = stock.minute_bars.where("created_at > ?", (@end_time - @history_minutes))
    bars.each_with_object({}) do |bar, hash|
      hash[bar.quote_time] = bar
    end
  end
end
