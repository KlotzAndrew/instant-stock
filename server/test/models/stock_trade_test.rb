# == Schema Information
#
# Table name: stock_trades
#
#  id               :uuid             not null, primary key
#  stock_holding_id :uuid             not null
#  quantity         :integer          not null
#  enter_price      :decimal(15, 2)
#  exit_price       :decimal(15, 2)
#  exit_time        :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class StockTradeTest < ActiveSupport::TestCase
  context '#relations' do
    should belong_to :stock_holding
    should have_one :stock
  end

  context '#validations' do
    should validate_presence_of :stock_holding_id
  end

  test '#holding equals stock_holding' do
    assert_equal StockTrade.new.holding, StockTrade.new.stock_holding
  end

  test '#stock_name' do
    holding = FactoryGirl.build :stock_holding, :with_stock_trade
    stock   = holding.stock
    trade   = holding.trades.first

    trade.expects(:stock).returns(stock)

    assert_equal stock.name, trade.stock_name
  end
end
