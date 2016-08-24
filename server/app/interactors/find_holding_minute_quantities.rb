class FindHoldingMinuteQuantities
  include Interactor

  def call
    @next_minute_base   = round_down_to_minute context.next_minute
    @end_time           = Time.zone.now
    @holding_quantities = {}

    @minute_quantities = {}
    @next_minute       = @next_minute_base

    build_minute_holdings context.holdings

    context.holding_quantities = @holding_quantities
  end

  private

  def build_minute_holdings(holdings)
    holdings.each do |holding|
      @next_minute                     = @next_minute_base
      @minute_quantities               = {}
      @minute_quantities[@next_minute] = 0

      build_minute_quantities holding.trades

      return set_by_stock_id(holding) if holding.respond_to? :stock
      set_by_holding_id holding
    end
  end

  def set_by_stock_id(holding)
    @holding_quantities[holding.stock.id] = @minute_quantities
  end

  def set_by_holding_id(holding)
    @holding_quantities[holding.id] = @minute_quantities
  end

  def build_minute_quantities(trades)
    trades_remaining = build_base_quantity trades

    build_quantity_by_minute trades_remaining
  end

  def build_quantity_by_minute(trades)
    while @next_minute < (@end_time - 1.minute)
      increment_next_minute
      trades = add_current_trades trades
    end
  end

  def add_current_trades(trades)
    trades.drop_while do |trade|
      add_trade_to_quantity trade
    end
  end

  def increment_next_minute
    previous_time                    = @next_minute
    @next_minute                    += 1.minute
    @minute_quantities[@next_minute] = @minute_quantities[previous_time]
  end

  def build_base_quantity(trades)
    trades.drop_while do |trade|
      add_trade_to_quantity trade
    end
  end

  def add_trade_to_quantity(trade)
    if trade.created_at < @next_minute
      @minute_quantities[@next_minute] += trade.quantity
    end
  end

  def round_down_to_minute(time)
    extra_seconds = time.to_i % 60
    Time.zone.at (time - extra_seconds)
  end
end
