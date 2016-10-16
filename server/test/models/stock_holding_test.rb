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
  def setup
    @holding = FactoryGirl.build :stock_holding, :with_stock_trade
  end

  context '#relations' do
    should belong_to :portfolio
    should belong_to :stock
    should have_many :stock_trades
  end

  context '#validations' do
    should validate_presence_of :portfolio_id
    should validate_presence_of :stock_id
  end

  test '#current_total returns current stock amount' do
    @holding = FactoryGirl.build :stock_holding
    trade_1 = FactoryGirl.build :stock_trade, stock_holding: @holding
    trade_2 = FactoryGirl.build :stock_trade, stock_holding: @holding
    @holding.stock_trades << trade_1
    @holding.stock_trades << trade_2

    expected_total = trade_1.quantity + trade_2.quantity

    assert_equal @holding.current_total, expected_total
  end

  test '#trades equals stock_trades' do
    StockHolding.new.trades == StockHolding.new.stock_trades
  end

  test '#stock_name' do
    assert_equal @holding.stock.name, @holding.stock_name
  end
end
