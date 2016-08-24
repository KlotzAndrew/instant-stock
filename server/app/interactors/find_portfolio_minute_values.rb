class FindPortfolioMinuteValues
  include Interactor

  DEFAULT_MINUTES = 90

  def call
    @start_time        = Time.zone.now
    @portfolio         = context.portfolio
    @history_minutes   = find_total_time context.history_minutes
    @portfolio_minutes = setup_portfolio_minutes @history_minutes

    update_stock_minute_bars
    find_portfolio_minute_values

    context.portfolio_minutes = @portfolio_minutes
  end

  private

  def find_portfolio_minute_values
    add_cash_holdings_to_portfolio_minutes get_cash_holding_quantities
    add_stock_holdings_to_portfolio_minutes get_stock_holding_quantities,
                                            get_stock_minute_values
  end

  def add_stock_holdings_to_portfolio_minutes(stock_quantities, minute_values)
    stock_quantities.each do |stock, quantiies|
      minutes = minute_values[stock]
      add_stock_minutes_to_portfolio quantiies, minutes
    end
  end

  def add_stock_minutes_to_portfolio(quantities, minutes)
    quantities.each do |time, value|
      @portfolio_minutes[time] += valuate_holding(time, value, minutes)
    end
  end

  def valuate_holding(time, value, minutes)
    until minutes[time]
      time -= 1.minute
      break if time < @history_minutes
    end
    value * minutes[time].close
  end

  def add_cash_holdings_to_portfolio_minutes(cash_holdings)
    cash_holdings.each do |_holding, values|
      add_cash_minute_values_to_portfolio values
    end
  end

  def add_cash_minute_values_to_portfolio(minute_values)
    minute_values.each do |time, value|
      @portfolio_minutes[time] += value
    end
  end

  def setup_portfolio_minutes(time)
    minutes = {}
    while time < (@start_time + 1.minute)
      minutes[time] = 0
      time         += 1.minute
    end
    minutes
  end

  def get_stock_minute_values
    params = {
      stocks:          @portfolio.stocks,
      history_minutes: @history_minutes
    }
    result = FindStockMinuteBars.call params
    result.stock_minute_bars
  end

  def get_cash_holding_quantities
    cash_holding_params = {
      holdings:    @portfolio.cash_holdings,
      next_minute: @history_minutes
    }

    result = FindHoldingMinuteQuantities.call cash_holding_params
    result.holding_quantities
  end

  def get_stock_holding_quantities
    stock_holding_params = {
      holdings:    @portfolio.stock_holdings,
      next_minute: @history_minutes
    }

    result = FindHoldingMinuteQuantities.call stock_holding_params
    result.holding_quantities
  end

  def find_total_time(time)
    minutes = time || DEFAULT_MINUTES
    Time.zone.now - minutes * 60
  end

  def update_stock_minute_bars
    UpdateStocksMinuteBars.call stocks: @portfolio.stocks
  end
end
