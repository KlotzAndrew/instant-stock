class TradeBroadcastJob < ApplicationJob
  queue_as :default

  def perform(trade)
    ActionCable.server.broadcast 'room_channel',
                                 trade: serialize_obj(trade)
  end

  def serialize_obj(trade)
    serializer = StockTradeSerializer.new(trade)
    adapter = ActiveModelSerializers::Adapter.create(serializer)
    adapter.to_json
  end
end
