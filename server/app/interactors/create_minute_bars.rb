class CreateMinuteBars
  include Interactor

  def call
    stock_minute_bars = context.stock_minute_bars

    create_minute_bars stock_minute_bars
  end

  private

  def create_minute_bars(stock_minute_bars)
    stock_minute_bars.each do |stock_minute_hash|
      create_bars_for_stock stock_minute_hash
    end
  end

  def create_bars_for_stock(stock_minute_bar)
    stock_id = stock_minute_bar[:stock_id]
    bars     = stock_minute_bar[:minute_bars]
    bars.each do |bar|
      create_minute_bar bar, stock_id
    end
  end

  def create_minute_bar(bar, stock_id)
    quote_time = round_time_to_minute bar[:quote_time]
    return if already_quoted? quote_time, stock_id
    MinuteBar.create(
      data_source:    bar[:data_source],
      quote_time:     quote_time,
      high:           bar[:high],
      open:           bar[:open],
      close:          bar[:close],
      low:            bar[:low],
      adjusted_close: bar[:adjusted_close],
      volume:         bar[:volume],
      stock_id:       stock_id
    )
  end

  def round_time_to_minute(quote_time)
    minute_seconds = 60
    rounded_minutes = (quote_time.to_r / minute_seconds).round
    Time.zone.at(rounded_minutes * minute_seconds)
  end

  # TODO: this can be a model validation now
  def already_quoted?(quote_time, stock_id)
    minute_bar = MinuteBar.find_by(
      stock_id:   stock_id,
      quote_time: quote_time
    )
    minute_bar.present? ? true : false
  end
end
