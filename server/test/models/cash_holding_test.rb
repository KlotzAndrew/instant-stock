# == Schema Information
#
# Table name: cash_holdings
#
#  id           :uuid             not null, primary key
#  amount       :decimal(15, 2)
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
  end

  context '#validations' do
    should validate_presence_of :portfolio_id
    should validate_presence_of :currency
  end

  test '#change_cash updates amount' do
    mock_amount = 100
    new_amount = @cash_holding.amount + mock_amount

    @cash_holding.expects(:update).with(amount: new_amount)

    @cash_holding.change_cash(mock_amount)
  end
end
