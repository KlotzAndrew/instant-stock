require 'test_helper'
require 'sidekiq/testing'

class TradeBroadcastJobTest < ActiveJob::TestCase
  def setup
    holding = FactoryGirl.build :stock_holding, :with_stock_trade
    @trade  = holding.trades[0]
  end

  test '#perform_later enqueues job' do
    TradeBroadcastJob.perform_later @trade

    assert_equal 1, enqueued_jobs.size
  end

  test '#perform broadcasts trade' do
    channel   = 'room_channel'
    broadcast = { :trade => serialize_obj(@trade) }

    ActionCable.server.expects(:broadcast).with(channel, broadcast)

    TradeBroadcastJob.new.perform(@trade)
  end

  def serialize_obj(trade)
    serializer = StockTradeSerializer.new(trade)
    adapter = ActiveModelSerializers::Adapter.create(serializer)
    adapter.to_json
  end
end
