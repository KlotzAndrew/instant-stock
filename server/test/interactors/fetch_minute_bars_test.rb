require 'test_helper'

class FetchMinuteBarsTest < ActiveSupport::TestCase
  test 'correctly returns hash of minute quotes for single stock' do
    VCR.use_cassette('yahoo_finance_chart_api') do
      stock = FactoryGirl.build :stock, ticker: 'GOOG'

      result = FetchMinuteBars.call stocks: [stock]

      assert result.success?

      minute_bars = result.stock_minute_bars
      assert_equal 1, minute_bars.size
      assert_equal stock.id, minute_bars.first[:stock_id]
      assert_equal 376, minute_bars.first[:minute_bars].size
      assert_equal mock_minute_bar, minute_bars.first[:minute_bars].first
    end
  end

  test 'invalid json' do
    skip 'tbd'
  end

  test 'no stock input' do
    skip 'tbd'
  end

  test 'api timeout' do
    skip 'tbd'
  end

  test 'api returns incorrect stock' do
    skip 'tbd'
  end

  private

  def mock_minute_bar
    {
      data_source:    FetchMinuteBars::DATA_SOURCE,
      quote_time:     Time.zone.at(1_470_403_851),
      high:           773.86,
      open:           773.0,
      close:          773.1302,
      low:            772.59,
      adjusted_close: nil,
      volume:         56_400
    }
  end
end
