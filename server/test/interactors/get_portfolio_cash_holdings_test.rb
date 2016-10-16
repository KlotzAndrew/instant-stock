require 'test_helper'

class GetPortfolioCashHoldingsTest < ActiveSupport::TestCase
  setup do
    @portfolio = FactoryGirl.build :portfolio,
                                   :with_cash
  end

  test '#call should return stock_holdings' do
    Portfolio.expects(:find).returns(@portfolio)

    result = GetPortfolioCashHoldings.call portfolio_id: @portfolio.id

    assert result.success?
    assert_equal @portfolio.cash_holdings, result.cash_holdings
  end
end
