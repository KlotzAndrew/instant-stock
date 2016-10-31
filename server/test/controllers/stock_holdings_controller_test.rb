require 'test_helper'

module Api
  module V1
    class StockHoldingsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @portfolio = FactoryGirl.build :portfolio,
                                       :with_stock_holding
        @stock_holding = @portfolio.stock_holdings.first
      end

      test 'should get index' do
        GetPortfolioStockHoldings.expects(:call).returns(@portfolio)

        get api_v1_portfolio_stock_holdings_url(@portfolio)

        body = JSON.parse @response.body

        assert_response :success
        assert_equal @stock_holding.id, body['data'][0]['id']
      end

      test 'should get new' do
        # get new_holding_url
        # assert_response :success
        skip 'tbd'
      end

      test 'should create holding' do
        # assert_difference('Holding.count') do
        #   post holdings_url, params: { holding: {  } }
        # end
        #
        # assert_redirected_to holding_path(Holding.last)
        skip 'tbd'
      end

      test 'should show holding' do
        # get holding_url(@holding)
        # assert_response :success
        skip 'tbd'
      end

      test 'should get edit' do
        # get edit_holding_url(@holding)
        # assert_response :success
        skip 'tbd'
      end

      test 'should update holding' do
        # patch holding_url(@holding), params: { holding: {  } }
        # assert_redirected_to holding_path(@holding)
        skip 'tbd'
      end

      test 'should destroy holding' do
        # assert_difference('Holding.count', -1) do
        #   delete holding_url(@holding)
        # end
        #
        # assert_redirected_to holdings_path
        skip 'tbd'
      end
    end
  end
end
