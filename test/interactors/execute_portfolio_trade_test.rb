require 'test_helper'

class ExecutePortfolioTradeTest < ActiveSupport::TestCase
  test 'calls correct interactors' do
    assert ExecutePortfolioTrade.organized.include? CheckChatCommand
    assert ExecutePortfolioTrade.organized.include? FetchStockQuotes
    assert ExecutePortfolioTrade.organized.include? UpdateStockFromQuote
    assert ExecutePortfolioTrade.organized.include? PerformStockTrade
  end
end
