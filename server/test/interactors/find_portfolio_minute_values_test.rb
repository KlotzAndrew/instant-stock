require 'test_helper'

class FindPortfolioMinuteValuesTest < ActiveSupport::TestCase
  setup do
    Timecop.freeze(Time.zone.local(2016, 8, 17, 0, 0, 0))
  end

  test '#call should return minute values for portfolio' do
    portfolio       = FactoryGirl.build :portfolio, :with_cash_and_stock
    history_minutes = 2
    params          = {
      portfolio:       portfolio,
      history_minutes: history_minutes
    }

    cash_holding  = portfolio.cash_holdings.first
    stock_holding = portfolio.stock_holdings.first
    stock         = stock_holding.stock

    stock_minute_bar_1 = FactoryGirl.build :minute_bar,
                                           stock: stock,
                                           quote_time: Time.zone.now
    stock.minute_bars << stock_minute_bar_1

    stock_minute_bar_2 = FactoryGirl.build :minute_bar,
                                           stock: stock,
                                           quote_time: (Time.zone.now - 1.minute)
    stock.minute_bars << stock_minute_bar_2

    stock_minute_bar_3 = FactoryGirl.build :minute_bar,
                                           stock: stock,
                                           quote_time: (Time.zone.now - 2.minutes)
    stock.minute_bars << stock_minute_bar_3

    UpdateStocksMinuteBars.expects(:call).with(stocks: portfolio.stocks)

    stock_minute_bars = {
      stock.id => {
        stock_minute_bar_3.quote_time => stock_minute_bar_3,
        stock_minute_bar_2.quote_time => stock_minute_bar_2,
        stock_minute_bar_1.quote_time => stock_minute_bar_1
      }
    }
    mock_stock_minute_bars = mock 'stock minute bars'
    mock_stock_minute_bars.expects(:stock_minute_bars)
                          .returns(stock_minute_bars)
    FindStockMinuteBars.expects(:call).returns(mock_stock_minute_bars)

    cash_holding_params = {
      holdings:    portfolio.cash_holdings,
      next_minute: (Time.zone.now - history_minutes * 60)
    }
    mock_cash_quantities = mock 'cash quantities'
    cash_quantities = {
      cash_holding.id => {
        Time.zone.now - 2.minutes => 1000,
        Time.zone.now - 1.minute  => 9000,
        Time.zone.now             => 4000
      }
    }
    mock_cash_quantities.expects(:holding_quantities).returns(cash_quantities)
    FindHoldingMinuteQuantities.expects(:call)
                               .with(cash_holding_params)
                               .returns(mock_cash_quantities)

    stock_holding_params = {
      holdings:    portfolio.stock_holdings,
      next_minute: (Time.zone.now - history_minutes * 60)
    }
    mock_stock_quantities = mock 'stock quantities'
    stock_quantities      = {
      stock_holding.stock.id => {
        Time.zone.now - 2.minutes => 3,
        Time.zone.now - 1.minute  => 3,
        Time.zone.now             => 4
      }
    }
    mock_stock_quantities.expects(:holding_quantities).returns(stock_quantities)
    FindHoldingMinuteQuantities.expects(:call)
                               .with(stock_holding_params)
                               .returns(mock_stock_quantities)

    t2 = Time.zone.now - 2.minutes
    t1 = Time.zone.now - 1.minute
    t  = Time.zone.now

    expected_portfolio_minutes = {
      t2 => cash_value(t2, cash_quantities, cash_holding) + stock_value(t2, stock_quantities, stock_minute_bars, stock_holding),
      t1 => cash_value(t1, cash_quantities, cash_holding) + stock_value(t1, stock_quantities, stock_minute_bars, stock_holding),
      t  => cash_value(t, cash_quantities, cash_holding) + stock_value(t, stock_quantities, stock_minute_bars, stock_holding)
    }

    result = FindPortfolioMinuteValues.call params

    assert result.success?
    assert_equal expected_portfolio_minutes, result.portfolio_minutes
  end

  test '#call dies when no minute bars' do
    skip 'tbd'
  end

  test '#call requires some params' do
    skip 'tbd'
  end

  test '#call validates history minutes' do
    skip 'tbd'
  end

  test '#call fails when update minute bars fails' do
    skip 'tbd'
  end

  test '#call does something when no minute bars before holding' do
    skip 'tbd'
  end

  test '#call does something when missing minute bar' do
    skip 'tbd'
  end

  test '#call uses default minute values when not passed in' do
    skip 'tbd'
  end

  private

  def cash_value(time, cash_quantities, cash_holding)
    cash_quantities[cash_holding.id][time]
  end

  def stock_value(time, stock_quantities, stock_minute_bars, stock_holding)
    quantity = stock_quantities[stock_holding.stock.id][time]
    value    = stock_minute_bars[stock_holding.stock.id][time].close
    quantity * value
  end
end
