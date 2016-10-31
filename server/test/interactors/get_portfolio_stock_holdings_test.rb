require 'test_helper'

class GetPortfolioStockHoldingsTest < ActiveSupport::TestCase
  setup do
    @portfolio = FactoryGirl.build :portfolio,
                                   :with_stock_holding
  end

  test '#call should return stock_holdings' do
    Portfolio.expects(:find).returns(@portfolio)

    result = GetPortfolioStockHoldings.call portfolio_id: @portfolio.id

    assert result.success?
    assert_equal @portfolio.stock_holdings, result.stock_holdings
  end
end
