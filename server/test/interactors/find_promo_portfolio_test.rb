require 'test_helper'

class FindPromoPortfolioTest < ActiveSupport::TestCase
  test '#call returns promo portfolio' do
    mock_portfolio = FactoryGirl.build :portfolio
    Portfolio.expects(:find_by)
             .with(promo_portfolio: true)
             .returns(mock_portfolio)

    result = FindPromoPortfolio.call

    assert result.success?
    assert_equal result.portfolio, mock_portfolio
  end

  test '#call fails when no portfolio found' do
    skip 'tbd'
  end
end
