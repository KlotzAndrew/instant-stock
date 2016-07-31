# == Schema Information
#
# Table name: cash_holdings
#
#  id           :uuid             not null, primary key
#  currency     :string           not null
#  portfolio_id :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class CashHoldingTest < ActiveSupport::TestCase
  def setup
    @cash_holding = FactoryGirl.build :cash_holding
  end

  context '#relations' do
    should belong_to :portfolio
    should have_many :cash_trades
  end

  context '#validations' do
    should validate_presence_of :portfolio_id
    should validate_presence_of :currency
  end

  test '#current_total returns correct value' do
    cash_trade_1 = FactoryGirl.build :cash_trade, quantity: 1_000
    cash_trade_2 = FactoryGirl.build :cash_trade, quantity: 1_000
    @cash_holding.cash_trades << cash_trade_1
    @cash_holding.cash_trades << cash_trade_2

    expected_total = cash_trade_1.quantity + cash_trade_2.quantity

    assert_equal expected_total, @cash_holding.current_total
  end

  test '#change_cash updates amount' do
    skip 'not sure this should be here'
    mock_amount = 100
    new_amount = @cash_holding.amount + mock_amount

    @cash_holding.expects(:update).with(amount: new_amount)

    @cash_holding.change_cash(mock_amount)
  end
end
