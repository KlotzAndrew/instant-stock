require 'test_helper'

class CashHoldingSerializerTest < ActiveJob::TestCase
  def setup
    # TODO: figure out why mocking fails here
    @holding            = FactoryGirl.create :cash_holding, :with_cash_trade
    @serialized_holding = JSON.parse(
      CashHoldingSerializer.new(@holding).to_json
    )
  end

  test 'should serialize' do
    serliazed_values = [
      :id, :currency, :portfolio_id, :current_total
    ]

    serliazed_values.each do |value|
      assert_serialized(@holding, @serialized_holding, value)
    end
  end

  def assert_serialized(obj, serialized_obj, value)
    assert_equal obj.send(value).to_s, serialized_obj[value.to_s]
  end
end
