require 'test_helper'

class CreateMinuteBarsTest < ActiveSupport::TestCase
  test '#call creates minute bars for stock' do
    stock               = FactoryGirl.build :stock, ticker: 'GOOG'
    stock_minute_bars   = [build_stock_minute_bar(stock)]
    expected_minute_bar = build_expected_minute_bar stock

    MinuteBar.expects(:create).with(expected_minute_bar)
    MinuteBar.expects(:find_by).with(
      stock_id:   stock.id,
      quote_time: Time.zone.local(2016, 8, 5, 12, 27, 0)
    )

    result = CreateMinuteBars.call stock_minute_bars: stock_minute_bars

    assert result.success?
  end

  test '#call does not create multiple quotes for same time' do
    stock               = FactoryGirl.build :stock, ticker: 'GOOG'
    stock_minute_bars   = [build_stock_two_minute_bar(stock)]
    expected_minute_bar = build_expected_minute_bar stock

    MinuteBar.expects(:create).with(expected_minute_bar)
    MinuteBar.expects(:find_by).times(2).with(
      stock_id:   stock.id,
      quote_time: Time.zone.local(2016, 8, 5, 12, 27, 0)
    ).returns(nil).then.returns(true)

    result = CreateMinuteBars.call stock_minute_bars: stock_minute_bars

    assert result.success?
  end

  test '#call rounds quote time to minute' do
    stock               = FactoryGirl.build :stock, ticker: 'GOOG'
    stock_minute_bars   = [build_stock_minute_bar(stock)]
    expected_minute_bar = build_expected_minute_bar stock

    saved_time_value = Time.zone.local(2016, 8, 5, 12, 27, 0)
    api_time_value   = stock_minute_bars[0][:minute_bars][0][:quote_time]

    MinuteBar.expects(:create).with(expected_minute_bar)
    MinuteBar.expects(:find_by).with(
      stock_id:   stock.id,
      quote_time: saved_time_value
    )

    result = CreateMinuteBars.call stock_minute_bars: stock_minute_bars

    assert result.success?

    refute_equal saved_time_value, api_time_value
    refute_equal 0, api_time_value.to_i % 60
    assert_equal 0, saved_time_value.to_i % 60
  end

  test '#call does nothing when no minute bars' do
    skip 'tbd'
  end

  private

  def build_stock_two_minute_bar(stock)
    {
      stock_id:    stock.id,
      minute_bars: [build_minute_bar, build_minute_bar]
    }
  end

  def build_stock_minute_bar(stock)
    {
      stock_id:    stock.id,
      minute_bars: [build_minute_bar]
    }
  end

  def build_minute_bar
    {
      data_source:    FetchMinuteBars::DATA_SOURCE,
      quote_time:     Time.zone.local(2016, 8, 5, 12, 26, 45),
      high:           4,
      open:           2,
      close:          3,
      low:            1,
      adjusted_close: nil,
      volume:         100
    }
  end

  def build_expected_minute_bar(stock)
    build_minute_bar.tap do |minute_bar|
      minute_bar[:stock_id] = stock.id
      minute_bar[:quote_time] = Time.zone.local 2016, 8, 5, 12, 27, 0
    end
  end
end
