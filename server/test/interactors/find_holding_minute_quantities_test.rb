require 'test_helper'

class FindHoldingMinuteQuantitiesTest < ActiveSupport::TestCase
  setup do
    @base_time = Timecop.freeze(Time.zone.local(2016, 8, 17, 0, 0, 30))
  end

  test '#call should return minute values for varied buys' do
    portfolio     = FactoryGirl.build :portfolio, :with_stock_holding
    stock_holding = portfolio.stock_holdings.first

    add_stock_trade_to_holding stock_holding, 1, @base_time - 360
    add_stock_trade_to_holding stock_holding, 1, @base_time - 300
    add_stock_trade_to_holding stock_holding, 1, @base_time - 240
    add_stock_trade_to_holding stock_holding, 1, @base_time - 60

    time = round_down_to_minute Time.zone.now

    expected_holding_quantities = {
      stock_holding.stock.id => {
        time - 4.minutes => 2,
        time - 3.minutes => 3,
        time - 2.minutes => 3,
        time - 1.minute  => 3,
        time             => 4
      }
    }

    params = {
      holdings: portfolio.stock_holdings,
      next_minute:    @base_time - 240
    }

    result = FindHoldingMinuteQuantities.call params

    assert result.success?
    assert_equal 1, result.holding_quantities.size
    assert_equal expected_holding_quantities, result.holding_quantities
  end

  test '#call should return minute values for cash' do
    portfolio    = FactoryGirl.build :portfolio, :with_cash_holding
    cash_holding = portfolio.cash_holdings.first

    add_cash_trade_to_holding cash_holding, 1, @base_time - 360
    add_cash_trade_to_holding cash_holding, 1, @base_time - 300
    add_cash_trade_to_holding cash_holding, 1, @base_time - 240
    add_cash_trade_to_holding cash_holding, 1, @base_time - 60

    time = round_down_to_minute Time.zone.now

    expected_holding_quantities = {
      cash_holding.id => {
        time - 4.minutes => 2,
        time - 3.minutes => 3,
        time - 2.minutes => 3,
        time - 1.minute  => 3,
        time             => 4
      }
    }

    params = {
      holdings: portfolio.cash_holdings,
      next_minute:    @base_time - 240
    }

    result = FindHoldingMinuteQuantities.call params

    assert result.success?
    assert_equal 1, result.holding_quantities.size

    minute_quantities = result.holding_quantities.first.last
    assert_equal 5, minute_quantities.size

    assert_equal expected_holding_quantities, result.holding_quantities
  end

  test '#call sets minutes to 00 seconds' do
    portfolio = FactoryGirl.build :portfolio, :with_stock_holding
    params    = {
      holdings:    portfolio.stock_holdings,
      next_minute: @base_time
    }

    result = FindHoldingMinuteQuantities.call params

    assert result.success?

    first_quantity     = result.holding_quantities.first.last
    first_time_measure = first_quantity.first.first.to_i
    assert_equal 0, first_time_measure % 60
  end

  test '#call needs some params' do
    skip 'tbd'
  end

  private

  def add_stock_trade_to_holding(holding, quantity, created_at)
    trade = FactoryGirl.build :stock_trade,
                              stock_holding: holding,
                              quantity:      quantity,
                              created_at:    created_at
    holding.stock_trades << trade
  end

  def add_cash_trade_to_holding(holding, quantity, created_at)
    trade = FactoryGirl.build :cash_trade,
                              cash_holding: holding,
                              quantity:      quantity,
                              created_at:    created_at
    holding.cash_trades << trade
  end

  def round_down_to_minute(time)
    extra_seconds = time.to_i % 60
    Time.zone.at(time - extra_seconds)
  end
end
