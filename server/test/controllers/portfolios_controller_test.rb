require 'test_helper'

module Api
  module V1
    class PortfoliosControllerTest < ActionDispatch::IntegrationTest
      setup do
        @portfolio = FactoryGirl.build :portfolio
      end

      test '#promo returns 200 and promo portfolio' do
        mock_result = mock 'promo result'
        mock_result.expects(:portfolio).returns(@portfolio)
        FindPromoPortfolio.expects(:call).returns(mock_result)

        get api_v1_promo_url

        body = JSON.parse @response.body

        assert_response :success
        assert_equal @portfolio.id, body['data']['id']
      end

      test 'should get index' do
        # get portfolios_url
        # assert_response :success
        skip 'tbd'
      end

      test 'should get new' do
        # get new_portfolio_url
        # assert_response :success
        skip 'tbd'
      end

      test 'should create portfolio' do
        # assert_difference('Portfolio.count') do
        #   post portfolios_url, params: { portfolio: {  } }
        # end
        #
        # assert_redirected_to portfolio_path(Portfolio.last)
        skip 'tbd'
      end

      test 'should show portfolio' do
        # get portfolio_url(@portfolio)
        # assert_response :success
        skip 'tbd'
      end

      test 'should get edit' do
        # get edit_portfolio_url(@portfolio)
        # assert_response :success
        skip 'tbd'
      end

      test 'should update portfolio' do
        # patch portfolio_url(@portfolio), params: { portfolio: {  } }
        # assert_redirected_to portfolio_path(@portfolio)
        skip 'tbd'
      end

      test 'should destroy portfolio' do
        # assert_difference('Portfolio.count', -1) do
        #   delete portfolio_url(@portfolio)
        # end
        #
        # assert_redirected_to portfolios_path
        skip 'tbd'
      end
    end
  end
end
