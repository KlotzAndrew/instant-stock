require 'test_helper'

class SerializeHoldingsAndTradesTest < ActiveSupport::TestCase
  test '#call returns all holdings with details' do
    portfolio = FactoryGirl.build :portfolio, :with_cash_and_stock
    params = { portfolio: portfolio }

    portfolio.cash_holdings.expects(:includes).returns(portfolio.cash_holdings)
    portfolio.stock_holdings.expects(:includes).returns(portfolio.stock_holdings)

    result = SerializeHoldingsAndTrades.call params

    assert result.success?
    cash_holding = portfolio.cash_holdings.first
    assert_correct_cash_holding cash_holding,
                                result.cash_holdings.first[:holding]
    assert_correct_cash_trade cash_holding.trades.first,
                              result.cash_holdings.first[:trades].first

    stock_holding = portfolio.stock_holdings.first
    assert_correct_stock_holding stock_holding,
                                 result.stock_holdings.first[:holding]
    assert_correct_stock_trade stock_holding.trades.first,
                              result.stock_holdings.first[:trades].first
  end

  test '#call fails when no portfolio' do
    skip 'tbd, should blow up'
  end

  private

  def assert_correct_stock_trade(expected_trade, trade)
    equal_attributes = [
      :id,
      :stock_holding_id,
      :quantity,
      :enter_price,
      :exit_price,
      :exit_time,
      :created_at,
      :updated_at
    ]
    assert_attributes_equal equal_attributes, expected_trade, trade
  end

  def assert_correct_cash_trade(expected_trade, trade)
    equal_attributes = [
      :id,
      :cash_holding_id,
      :quantity,
      :created_at,
      :updated_at
    ]
    assert_attributes_equal equal_attributes, expected_trade, trade
  end

  def assert_correct_cash_holding(expected_holding, holding)
    equal_attributes = [
      :id,
      :current_total,
      :currency,
      :portfolio_id,
      :created_at,
      :updated_at
    ]
    assert_attributes_equal equal_attributes, expected_holding, holding
  end

  def assert_correct_stock_holding(expected_holding, holding)
    assert_equal expected_holding.stock.name, holding['name']
    equal_attributes = [
      :id,
      :current_total,
      :portfolio_id,
      :stock_id,
      :created_at,
      :updated_at
    ]
    assert_attributes_equal equal_attributes, expected_holding, holding
  end

  def assert_attributes_equal(attrs, object, hash)
    attrs.each do |a|
      assert_equal object.send(a), hash[a.to_s]
    end
  end
end
