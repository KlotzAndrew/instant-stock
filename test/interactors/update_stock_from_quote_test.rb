require 'test_helper'

class UpdateStockFromQuoteTest < ActiveSupport::TestCase
  test 'creates new stock from quote' do
    mapped_values = map_quote_to_stock mock_quotes[0]
    expected_stock = Stock.new mapped_values
    Stock.expects(:create).with(mapped_values).returns(expected_stock)

    result = UpdateStockFromQuote.call({quotes: mock_quotes})

    assert result.success?
    assert_equal result.stocks, [expected_stock]
  end

  test 'updates stock from quote' do
    expected_stock = Stock.new
    expect_search = search_values mock_quotes[0]
    expected_update = update_values mock_quotes[0]

    Stock.expects(:find_by).with(expect_search).returns(expected_stock)
    expected_stock.expects(:update)
      .with(expected_update)
      .returns(true)

    result = UpdateStockFromQuote.call({quotes: mock_quotes})

    assert result.success?
    assert_equal result.stocks, [expected_stock]
  end

  test 'raises error when no quotes' do
    skip 'need to impliment'
  end

  test 'raises error when quote information missing' do
    skip 'fail interactor or object?'
  end

  private

  def update_values(quote)
    {
      last_quote:      quote[:last_price],
      last_quote_time: quote[:last_trade]
    }
  end

  def search_values(quote)
    {
      ticker:         quote[:ticker],
      stock_exchange: quote[:stock_exchange]
    }
  end

  def mock_quotes
    [
      {
        :ticker         => 'GOOG',
        :name           => 'Alphabet Inc.',
        :last_price     => 19.99,
        :last_trade     => '2016-06-14T16:00:00-04:00',
        :stock_exchange => 'NMS'
      }
    ]
  end

  def map_quote_to_stock(quote)
    {
      ticker:          quote[:ticker],
      stock_exchange:  quote[:stock_exchange],
      last_quote_time: quote[:last_trade],
      last_quote:      quote[:last_price],
      name:            quote[:name]
    }
  end
end
