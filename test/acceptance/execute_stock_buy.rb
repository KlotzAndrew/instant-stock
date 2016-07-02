require 'test_helper'
require 'integration_test_helper'

class ExecuteStockBuyTest < ActionDispatch::IntegrationTest
  def setup
    @portfolio = FactoryGirl.create :portfolio
    @holding = FactoryGirl.create :cash_holding, portfolio: @portfolio
  end

  test 'visit portfolio' do
    visit '/'
    binding.pry
  end
end
