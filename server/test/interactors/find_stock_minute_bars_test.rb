require 'test_helper'

class FindStockMinuteBarsTest < ActiveSupport::TestCase
  setup do
    Timecop.freeze(Time.zone.local(2016, 8, 17, 0, 0, 30))
  end

  test '#call should return minute bars with history minutes' do
    stock           = FactoryGirl.build :stock
    stocks          = [stock]
    minute_bar      = FactoryGirl.build :minute_bar
    minute_bars     = [minute_bar]
    history_minutes = 100
    params          = {
      stocks:          stocks,
      history_minutes: history_minutes
    }

    expected_result = {
      stock.id => {
        minute_bar.quote_time => minute_bar
      }
    }

    stock.minute_bars
         .expects(:where)
         .with('created_at > ?', (Time.zone.now - history_minutes))
         .returns(minute_bars)

    result = FindStockMinuteBars.call params

    assert result.success?
    assert_equal expected_result, result.stock_minute_bars
  end

  test '#call should use default time when not provided' do
    skip 'tbd'
  end

  test '#call should require params' do
    skip 'tbd'
  end
end
