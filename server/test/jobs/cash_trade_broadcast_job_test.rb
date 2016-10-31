require 'test_helper'
require 'sidekiq/testing'

class CashTradeBroadcastJobTest < ActiveJob::TestCase
  def setup
    holding = FactoryGirl.build :cash_holding, :with_cash_trade
    @trade  = holding.trades[0]
  end

  test '#perform_later enqueues job' do
    CashTradeBroadcastJob.perform_later @trade

    assert_equal 1, enqueued_jobs.size
  end

  test '#perform broadcasts trade' do
    channel   = 'room_channel'
    broadcast = { cash_trade: serialize_obj(@trade) }

    ActionCable.server.expects(:broadcast).with(channel, broadcast)

    CashTradeBroadcastJob.new.perform(@trade)
  end

  def serialize_obj(trade)
    serializer = CashTradeSerializer.new(trade)
    adapter = ActiveModelSerializers::Adapter.create(serializer)
    adapter.to_json
  end
end
