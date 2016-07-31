require 'test_helper'
require 'integration_test_helper'

class MessageToTradeTest < ActionDispatch::IntegrationTest
  def setup
    time = Time.local(2016, 7, 31, 14, 0, 0)
    Timecop.freeze(time)

    @portfolio = Portfolio.create(
      name: 'demo portfolio',
      promo_portfolio: true
    )
    cash_holding = CashHolding.create(
      currency: CashHolding::USD,
      amount: 1_000_000
    )
    @portfolio.cash_holdings << cash_holding
  end

  test 'sending a message should correctly buy a stock' do
    VCR.use_cassette('yahoo_finance_api') do
      stock_ticker   = 'TSLA'
      stock_quantity = '120'
      message_params = {
        portfolio_id: @portfolio.id,
        content:      "buy #{stock_ticker} #{stock_quantity}"
      }

      post api_v1_portfolio_messages_url message_params

      new_message_content = @portfolio.messages.last.content
      assert_equal message_params[:content], new_message_content

      new_stock_holding = @portfolio.stock_holdings.last.stock
      assert_equal stock_ticker, new_stock_holding.ticker

      new_holding_value = @portfolio.stock_holdings.last.current_total
      assert_equal stock_quantity.to_i, new_holding_value
    end
  end
end
