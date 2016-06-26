# == Schema Information
#
# Table name: cash_holdings
#
#  id           :integer          not null, primary key
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

  test '#change_cash updates amount' do
    mock_amount = 100
    new_amount = @cash_holding.amount + mock_amount

    @cash_holding.expects(:update).with(amount: new_amount)

    @cash_holding.change_cash(mock_amount)
  end
end
