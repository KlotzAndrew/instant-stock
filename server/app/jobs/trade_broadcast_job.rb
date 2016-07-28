class TradeBroadcastJob < ApplicationJob
  queue_as :default

  def perform(trade)
    ActionCable.server.broadcast 'room_channel',
                                 trade: render_trade(trade)
  end

  def render_trade(trade)
    {
      id:          trade.id,
      stock_name:  trade.holding.stock.name,
      quantity:    trade.quantity,
      enter_price: trade.enter_price
    }.to_json
  end
end
