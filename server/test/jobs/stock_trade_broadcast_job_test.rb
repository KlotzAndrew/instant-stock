require 'test_helper'
require 'sidekiq/testing'

class StockTradeBroadcastJobTest < ActiveJob::TestCase
  def setup
    # TODO: figure out why serializer db requests not mocking
    holding = FactoryGirl.create :stock_holding, :with_stock_trade
    @trade  = holding.trades[0]
  end

  test '#perform_later enqueues job' do
    expected_count = enqueued_jobs.size + 1
    StockTradeBroadcastJob.perform_later @trade

    assert_equal expected_count, enqueued_jobs.size
  end

  test '#perform broadcasts trade' do
    channel   = 'room_channel'
    broadcast = { stock_trade: serialize_obj(@trade) }

    ActionCable.server.expects(:broadcast).with(channel, broadcast)

    StockTradeBroadcastJob.new.perform(@trade)
  end

  def serialize_obj(trade)
    serializer = StockTradeSerializer.new(trade)
    adapter = ActiveModelSerializers::Adapter.create(serializer)
    adapter.to_json
  end
end
