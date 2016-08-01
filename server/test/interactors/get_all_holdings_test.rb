require 'test_helper'

class GetAllHoldingsTest < ActiveSupport::TestCase
  test '#call returns all holdings with details' do
    portfolio = FactoryGirl.build :portfolio, :with_cash_and_stock
    params = { portfolio: portfolio }

    result = GetAllHoldings.call params

    assert result.success?
    assert_correct_cash_holding portfolio.cash_holdings.first,
                                result.cash_holdings.first

    assert_correct_stock_holding portfolio.stock_holdings.first,
                                 result.stock_holdings.first
  end

  test '#call fails when no portfolio' do
    skip 'tbd, should blow up'
  end

  private

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
