require 'test_helper'

class PortfolioPositionUpdaterTest < ActiveSupport::TestCase
  test '#update gets new quotes & updates position' do
    portfolio = FactoryGirl.build :portfolio, :with_stock_holding

    mock_promo_finder = 'mock promo'
    FindPromoPortfolio.expects(:call).returns(mock_promo_finder)
    mock_promo_finder.expects(:portfolio).returns(portfolio)


    mock_quote_updater = 'mock quote updater'
    CurrentQuotesUpdater.expects(:new).with(
      portfolio.stocks
    ).returns(mock_quote_updater)
    mock_quote_updater.expects(:update)

    PortfolioPositionUpdater.new.update
  end
end
