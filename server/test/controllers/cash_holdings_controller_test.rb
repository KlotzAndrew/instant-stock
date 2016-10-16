require 'test_helper'

module Api
  module V1
    class CashHoldingsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @portfolio = FactoryGirl.build :portfolio,
                                       :with_cash
        @cash_holding = @portfolio.cash_holdings.first
      end

      test 'should get index' do
        GetPortfolioCashHoldings.expects(:call).returns(@portfolio)

        get api_v1_portfolio_cash_holdings_url(@portfolio)

        body = JSON.parse @response.body

        assert_response :success
        assert_equal @cash_holding.id, body['data'][0]['id']
      end

      test 'should get new' do
        # get new_cash_holding_url
        # assert_response :success
        skip 'tbd'
      end

      test 'should create cash_holding' do
        # assert_difference('CashHolding.count') do
        #   post cash_holdings_url, params: { cash_holding: {  } }
        # end
        #
        # assert_redirected_to cash_holding_url(CashHolding.last)
        skip 'tbd'
      end

      test 'should show cash_holding' do
        # get cash_holding_url(@cash_holding)
        # assert_response :success
        skip 'tbd'
      end

      test 'should get edit' do
        # get edit_cash_holding_url(@cash_holding)
        # assert_response :success
        skip 'tbd'
      end

      test 'should update cash_holding' do
        # patch cash_holding_url(@cash_holding), params: { cash_holding: {  } }
        # assert_redirected_to cash_holding_url(@cash_holding)
        skip 'tbd'
      end

      test 'should destroy cash_holding' do
        # assert_difference('CashHolding.count', -1) do
        #   delete cash_holding_url(@cash_holding)
        # end
        #
        # assert_redirected_to cash_holdings_url
        skip 'tbd'
      end
    end
  end
end
