require 'test_helper'

module Api
  module V1
    class PortfoliosControllerTest < ActionDispatch::IntegrationTest
      setup do
        @portfolio = FactoryGirl.build :portfolio
      end

      test '#promo returns 200 and promo portfolio' do
        expected_portfolio = JSON.parse(
          {
            id:         @portfolio.id,
            name:       @portfolio.name,
            created_at: @portfolio.created_at,
            updated_at: @portfolio.updated_at
          }.to_json
        )
        expected_value = 99
        mock_interactor = mock 'mock interactor'
        mock_interactor.expects(:success?).returns(true)
        mock_interactor.expects(:portfolio).returns(expected_portfolio)
        mock_interactor.expects(:value).returns(expected_value)
        ReturnPromoPortfolio.expects(:call).returns(mock_interactor)

        get api_v1_promo_url

        body = JSON.parse @response.body

        assert_response :success
        assert_equal body['portfolio'], expected_portfolio
        assert_equal body['value'], expected_value
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
