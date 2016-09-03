class FindStockMinuteBars
  include Interactor

  DEFAULT_HISTORY_MINUTES = 90

  def call
    @end_time     = Time.zone.now
    @stocks       = context.stocks
    @history_time = context.history_time || find_total_time(context.history_minutes)

    stock_minute_bars = find_stock_minute_bars
    context.stock_minute_bars = stock_minute_bars
  end

  private

  def find_stock_minute_bars
    @stocks.map do |stock|
      {
        stock: stock,
        minute_bars: get_minute_bars(stock)
      }
    end
  end

  def get_minute_bars(stock)
    bars = stock.minute_bars.where("created_at > ?", @history_time)
    # bars.each_with_object({}) do |bar, hash|
    #   hash[bar.quote_time] = bar
    # end
    bars.map { |bar| bar.attributes }
  end

  def find_total_time(minutes)
    minutes ||= DEFAULT_HISTORY_MINUTES
    total_time = Time.zone.now - minutes * 60
    round_down_to_minute total_time
  end

  def round_down_to_minute(time)
    extra_seconds = time.to_i % 60
    Time.zone.at (time - extra_seconds)
  end
end
