require 'test_helper'

class StockHoldingSerializerTest < ActiveJob::TestCase
  def setup
    # TODO: figure out why mocking fails here
    @holding = FactoryGirl.create :stock_holding, :with_stock_trade

    # @holding.expects(:stock).returns(@holding.stock).at_least(1)
    @serialized_holding = JSON.parse(
      StockHoldingSerializer.new(@holding).to_json
    )
  end

  test 'should serialize' do
    serliazed_values = [
      :id, :portfolio_id, :stock_id, :current_total, :stock_name, :last_quote
    ]

    serliazed_values.each do |value|
      assert_serialized(@holding, @serialized_holding, value)
    end
  end

  def assert_serialized(obj, serialized_obj, value)
    assert_equal obj.send(value), serialized_obj[value.to_s]
  end
end
