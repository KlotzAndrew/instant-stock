# == Schema Information
#
# Table name: stock_holdings
#
#  id           :uuid             not null, primary key
#  active       :boolean          default(TRUE), not null
#  portfolio_id :uuid             not null
#  stock_id     :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class StockHoldingTest < ActiveSupport::TestCase
  test '#current_total returns current stock amount' do
    holding = FactoryGirl.build :stock_holding
    trade_1 = FactoryGirl.build :stock_trade, stock_holding: holding
    trade_2 = FactoryGirl.build :stock_trade, stock_holding: holding
    holding.stock_trades << trade_1
    holding.stock_trades << trade_2

    expected_total = trade_1.quantity + trade_2.quantity

    assert_equal holding.current_total, expected_total
  end
end
