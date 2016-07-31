require 'test_helper'

class CashTradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    skip 'tbd'
    @cash_trade = cash_trades(:one)
  end

  test 'should get index' do
    skip 'tbd'
    get cash_trades_url, as: :json
    assert_response :success
  end

  test 'should create cash_trade' do
    skip 'tbd'
    assert_difference('CashTrade.count') do
      post cash_trades_url, params: { cash_trade: {  } }, as: :json
    end

    assert_response 201
  end

  test 'should show cash_trade' do
    skip 'tbd'
    get cash_trade_url(@cash_trade), as: :json
    assert_response :success
  end

  test 'should update cash_trade' do
    skip 'tbd'
    patch cash_trade_url(@cash_trade), params: { cash_trade: {  } }, as: :json
    assert_response 200
  end

  test 'should destroy cash_trade' do
    skip 'tbd'
    assert_difference('CashTrade.count', -1) do
      delete cash_trade_url(@cash_trade), as: :json
    end

    assert_response 204
  end
end
