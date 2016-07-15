class TradeBroadcastJob < ApplicationJob
  queue_as :default

  def perform(trade)
    ActionCable.server.broadcast 'room_channel',
                                 trade: render_trade(trade)
  end

  def render_trade(trade)
    ApplicationController.renderer.render(
      partial: 'trades/trade', locals: { trade: trade }
    )
  end
end
