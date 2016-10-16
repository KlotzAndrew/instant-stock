require 'test_helper'

class StockTradeSerializerTest < ActiveJob::TestCase
  def setup
    holding = FactoryGirl.build :stock_holding, :with_stock_trade
    @trade  = holding.trades[0]

    @trade.expects(:stock).returns(holding.stock).twice
    @serialized_trade = JSON.parse(StockTradeSerializer.new(@trade).to_json)
  end

  test 'should serialize' do
    serliazed_values = [
      :id, :stock_holding_id, :quantity, :enter_price, :created_at, :stock_name
    ]

    serliazed_values.each do |value|
      assert_serialized(@trade, @serialized_trade, value)
    end
  end

  def assert_serialized(obj, serialized_obj, value)
    assert_equal obj.send(value), serialized_obj[value.to_s]
  end
end
