require 'test_helper'

class CashHoldingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cash_holding = cash_holdings(:one)
  end

  test "should get index" do
    get cash_holdings_url
    assert_response :success
  end

  test "should get new" do
    get new_cash_holding_url
    assert_response :success
  end

  test "should create cash_holding" do
    assert_difference('CashHolding.count') do
      post cash_holdings_url, params: { cash_holding: {  } }
    end

    assert_redirected_to cash_holding_url(CashHolding.last)
  end

  test "should show cash_holding" do
    get cash_holding_url(@cash_holding)
    assert_response :success
  end

  test "should get edit" do
    get edit_cash_holding_url(@cash_holding)
    assert_response :success
  end

  test "should update cash_holding" do
    patch cash_holding_url(@cash_holding), params: { cash_holding: {  } }
    assert_redirected_to cash_holding_url(@cash_holding)
  end

  test "should destroy cash_holding" do
    assert_difference('CashHolding.count', -1) do
      delete cash_holding_url(@cash_holding)
    end

    assert_redirected_to cash_holdings_url
  end
end
